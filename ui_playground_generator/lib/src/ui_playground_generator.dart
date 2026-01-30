import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:ui_playground_annotations/ui_playground_annotations.dart';
import 'package:ui_playground_generator/src/writor/input/input_code_writor.dart';

import 'parameter_analyzer.dart';

/// Type checker for @UiPlaygroundComponent annotation
final _componentChecker = TypeChecker.fromUrl(
  'package:ui_playground_annotations/src/component.dart#UiPlaygroundComponent',
);

/// Generator that automatically finds all @UiPlaygroundComponent annotated
/// classes and generates playground items for them.
///
/// Also supports external components specified in the @UiPlaygroundComponents
/// annotation for widgets from packages you cannot modify.
///
/// Triggered by @UiPlaygroundComponents annotation on a class.
class UiPlaygroundAggregatingGenerator extends GeneratorForAnnotation<UiPlaygroundComponents> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final buffer = StringBuffer();
    final imports = <String>{};
    final generatedCode = <String>[];
    final itemClassNames = <String>[];

    // Check if we should only use explicit components
    final extraComponentsOnly = annotation.peek('extraComponentsOnly')?.boolValue ?? false;

    // Parse global custom inputs (keyed by type name)
    final globalCustomInputs = _parseCustomInputs(annotation);

    // Add imports for global custom inputs
    _addImportsForCustomInputs(globalCustomInputs, imports);

    // 1. Process external components from the annotation
    final extraComponentsList = annotation.peek('extraComponents')?.listValue ?? [];
    for (final extraComponentValue in extraComponentsList) {
      final componentReader = ConstantReader(extraComponentValue);
      final typeValue = componentReader.peek('type')?.typeValue;
      if (typeValue == null) continue;

      final classElement = _getClassElement(typeValue);
      if (classElement == null) continue;

      final title = componentReader.peek('title')?.stringValue;
      final excludeParams =
          componentReader.peek('excludeParams')?.listValue.map((e) => e.toStringValue()!).toList() ?? [];
      final customInputs = _parseCustomInputs(componentReader);

      // Add imports for per-component custom inputs
      _addImportsForCustomInputs(customInputs, imports);

      final code = _generateCodeForClassWithConfig(
        classElement,
        title: title,
        excludeParams: excludeParams,
        customInputs: customInputs,
        globalCustomInputs: globalCustomInputs,
      );
      if (code != null) {
        generatedCode.add(code.code);
        itemClassNames.add(code.itemClassName);
        _addImportForElement(classElement, imports);
      }
    }

    // 2. Find all Dart files in lib/ with @UiPlaygroundComponent (unless componentsOnly is true)
    if (!extraComponentsOnly) {
      final dartFiles = Glob('lib/**.dart');

      await for (final input in buildStep.findAssets(dartFiles)) {
        // Skip generated files
        if (input.path.endsWith('.g.dart') || input.path.endsWith('.ui_playground.dart')) {
          continue;
        }

        // Try to resolve the library
        final LibraryElement? library;
        try {
          library = await buildStep.resolver.libraryFor(input);
        } catch (_) {
          continue;
        }

        // Find all classes with @UiPlaygroundComponent using LibraryReader
        final libraryReader = LibraryReader(library);
        for (final classElement in libraryReader.classes) {
          final componentAnnotation = _componentChecker.firstAnnotationOf(
            classElement,
          );
          if (componentAnnotation != null) {
            final reader = ConstantReader(componentAnnotation);
            final componentCustomInputs = _parseCustomInputs(reader);

            // Add imports for per-component custom inputs
            _addImportsForCustomInputs(componentCustomInputs, imports);

            final code = _generateCodeForClass(
              classElement,
              reader,
              customInputs: componentCustomInputs,
              globalCustomInputs: globalCustomInputs,
            );
            if (code != null) {
              generatedCode.add(code.code);
              itemClassNames.add(code.itemClassName);
              _addImportForElement(classElement, imports);
            }
          }
        }
      }
    }

    if (generatedCode.isEmpty) {
      return '// No components found';
    }

    buffer.writeln("// ignore_for_file: implementation_imports, sort_child_properties_last");

    // Write imports - this is a standalone library file
    buffer.writeln("import 'package:flutter/material.dart';");
    buffer.writeln("import 'package:ui_playground/ui_playground.dart';");
    for (final import in imports.toList()..sort()) {
      buffer.writeln(import);
    }
    buffer.writeln();

    // Write the aggregating class
    buffer.writeln(
      '// **************************************************************************',
    );
    buffer.writeln('// GeneratedUiPlaygroundComponents');
    buffer.writeln(
      '// **************************************************************************',
    );
    buffer.writeln();
    buffer.writeln('class GeneratedUiPlaygroundComponents {');
    buffer.writeln('  GeneratedUiPlaygroundComponents._();');
    buffer.writeln();
    buffer.writeln('  static List<UiPlaygroundItem> get items => [');
    for (final itemClassName in itemClassNames) {
      buffer.writeln('    $itemClassName(),');
    }
    buffer.writeln('  ];');
    buffer.writeln('}');
    buffer.writeln();
    buffer.writeln();

    // Write generated code for each component
    for (final code in generatedCode) {
      buffer.writeln(code);
    }
    return buffer.toString();
  }

  ClassElement? _getClassElement(DartType type) {
    final element = type.element;
    if (element is ClassElement) {
      return element;
    }
    return null;
  }

  /// Parses the customInputs list from a ConstantReader.
  ///
  /// Each item in the list is a Type that extends `UiPlaygroundInputItem<T>`.
  /// This method extracts the target type `T` from the generic parameter
  /// and returns a map of typeName -> CustomInputConfig (including import URI).
  Map<String, CustomInputConfig> _parseCustomInputs(ConstantReader reader) {
    final customInputsMap = <String, CustomInputConfig>{};
    final customInputsList = reader.peek('customInputs')?.listValue ?? [];

    for (final inputTypeValue in customInputsList) {
      final inputType = inputTypeValue.toTypeValue();
      if (inputType == null) continue;

      final inputClassElement = inputType.element;
      if (inputClassElement is! ClassElement) continue;

      final inputClassName = inputClassElement.name;
      if (inputClassName == null) continue;

      // Find the UiPlaygroundInputItem<T> supertype and extract T
      final targetTypeName = _extractInputItemGenericType(inputClassElement);
      if (targetTypeName == null) continue;

      // Get the import URI for this custom input class
      final library = inputClassElement.library;
      final uri = library.identifier;
      final importUri = uri.startsWith('package:') ? uri : null;

      customInputsMap[targetTypeName] = CustomInputConfig(
        inputClass: inputClassName,
        importUri: importUri,
      );
    }

    return customInputsMap;
  }

  /// Extracts the generic type parameter `T` from `UiPlaygroundInputItem<T>`.
  ///
  /// Returns the type name (e.g., 'EdgeInsets') or null if not found.
  String? _extractInputItemGenericType(ClassElement classElement) {
    // Check all supertypes (including mixins and interfaces)
    for (final supertype in classElement.allSupertypes) {
      final element = supertype.element;
      if (element.name == 'UiPlaygroundInputItem') {
        // Get the type arguments
        final typeArgs = supertype.typeArguments;
        if (typeArgs.isNotEmpty) {
          final targetType = typeArgs.first;
          final targetElement = targetType.element;
          if (targetElement != null) {
            return targetElement.name;
          }
        }
      }
    }
    return null;
  }

  void _addImportForElement(ClassElement classElement, Set<String> imports) {
    final library = classElement.library;
    final uri = library.identifier;
    if (uri.startsWith('package:')) {
      imports.add("import '$uri';");
    }
  }

  /// Adds imports for all custom input classes.
  void _addImportsForCustomInputs(
    Map<String, CustomInputConfig> customInputs,
    Set<String> imports,
  ) {
    for (final config in customInputs.values) {
      if (config.importUri != null) {
        imports.add("import '${config.importUri}';");
      }
    }
  }

  /// Generate code for a class with explicit configuration (from @UiPlaygroundComponents)
  _GeneratedCode? _generateCodeForClassWithConfig(
    ClassElement classElement, {
    String? title,
    List<String> excludeParams = const [],
    Map<String, CustomInputConfig> customInputs = const {},
    Map<String, CustomInputConfig> globalCustomInputs = const {},
  }) {
    final classNameNullable = classElement.name;
    if (classNameNullable == null || classNameNullable.isEmpty) {
      return null;
    }
    final className = classNameNullable;

    final resolvedTitle = title ?? className;

    // Find the constructor (prefer unnamed, then first)
    final constructor =
        classElement.unnamedConstructor ??
        (classElement.constructors.isNotEmpty ? classElement.constructors.first : null);

    if (constructor == null) {
      return null;
    }

    // Analyze parameters
    final formalParameters = constructor.formalParameters;
    final parameters = ParameterAnalyzer.analyze(
      formalParameters,
      excludeParams: ['key', ...excludeParams],
      customInputs: customInputs,
      globalCustomInputs: globalCustomInputs,
    );

    final itemClassName = '${className}PlaygroundItem';

    return _GeneratedCode(
      code: InputCodeWritor.generateCode(
        className: className,
        title: resolvedTitle,
        parameters: parameters,
      ),
      itemClassName: itemClassName,
    );
  }

  /// Generate code for a class with @UiPlaygroundComponent annotation
  _GeneratedCode? _generateCodeForClass(
    ClassElement classElement,
    ConstantReader annotation, {
    Map<String, CustomInputConfig> customInputs = const {},
    Map<String, CustomInputConfig> globalCustomInputs = const {},
  }) {
    final classNameNullable = classElement.name;
    if (classNameNullable == null || classNameNullable.isEmpty) {
      return null;
    }
    final className = classNameNullable;

    // Get annotation values
    final title = annotation.peek('title')?.stringValue ?? className;
    final excludeParams = annotation.peek('excludeParams')?.listValue.map((e) => e.toStringValue()!).toList() ?? [];

    // Find the constructor (prefer unnamed, then first)
    final constructor =
        classElement.unnamedConstructor ??
        (classElement.constructors.isNotEmpty ? classElement.constructors.first : null);

    if (constructor == null) {
      return null;
    }

    // Analyze parameters
    final formalParameters = constructor.formalParameters;
    final parameters = ParameterAnalyzer.analyze(
      formalParameters,
      excludeParams: ['key', ...excludeParams],
      customInputs: customInputs,
      globalCustomInputs: globalCustomInputs,
    );

    final itemClassName = '${className}PlaygroundItem';

    return _GeneratedCode(
      code: InputCodeWritor.generateCode(
        className: className,
        title: title,
        parameters: parameters,
      ),
      itemClassName: itemClassName,
    );
  }
}

class _GeneratedCode {
  final String code;
  final String itemClassName;

  _GeneratedCode({
    required this.code,
    required this.itemClassName,
  });
}
