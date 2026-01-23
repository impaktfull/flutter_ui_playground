import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:ui_playground_annotations/ui_playground_annotations.dart';

import 'parameter_analyzer.dart';

/// Generator that creates UiPlaygroundItem classes for widgets annotated
/// with @UiPlaygroundComponent.
class UiPlaygroundComponentGenerator
    extends GeneratorForAnnotation<UiPlaygroundComponent> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@UiPlaygroundComponent can only be applied to classes.',
        element: element,
      );
    }

    final classElement = element;
    final classNameNullable = classElement.name;
    if (classNameNullable == null || classNameNullable.isEmpty) {
      throw InvalidGenerationSourceError(
        'Class must have a name.',
        element: element,
      );
    }
    final className = classNameNullable;

    // Get annotation values
    final title =
        annotation.peek('title')?.stringValue ?? _formatTitle(className);
    final excludeParams =
        annotation
            .peek('excludeParams')
            ?.listValue
            .map((e) => e.toStringValue()!)
            .toList() ??
        [];

    // Find the constructor (prefer unnamed, then first)
    final constructor =
        classElement.unnamedConstructor ??
        (classElement.constructors.isNotEmpty
            ? classElement.constructors.first
            : null);

    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'Class $className must have a constructor.',
        element: element,
      );
    }

    // Analyze parameters - get the formal parameters from the constructor
    final formalParameters = constructor.formalParameters;
    final parameters = ParameterAnalyzer.analyze(
      formalParameters,
      excludeParams: ['key', ...excludeParams],
    );

    // Generate code
    return _generateCode(
      className: className,
      title: title,
      parameters: parameters,
      classElement: classElement,
    );
  }

  String _formatTitle(String className) {
    // Remove common prefixes
    var title = className;
    if (title.startsWith('ImpaktfullUi')) {
      title = title.substring('ImpaktfullUi'.length);
    }

    // Add spaces before capital letters
    title = title.replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]'),
      (match) => ' ${match.group(0)}',
    );

    return title;
  }

  String _generateCode({
    required String className,
    required String title,
    required List<AnalyzedParameter> parameters,
    required ClassElement classElement,
  }) {
    final itemClassName = '${className}PlaygroundItem';
    final variantClassName = '${className}PlaygroundVariant';
    final inputsClassName = '${className}PlaygroundInputs';

    final buffer = StringBuffer();

    // Generate Item class
    buffer.writeln('/// Generated UiPlaygroundItem for $className');
    buffer.writeln('class $itemClassName extends UiPlaygroundItem {');
    buffer.writeln('  @override');
    buffer.writeln("  String get title => '$title';");
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  List<UiPlaygroundVariant> get variants => [');
    buffer.writeln('    $variantClassName(),');
    buffer.writeln('  ];');
    buffer.writeln('}');
    buffer.writeln();

    // Generate Variant class
    buffer.writeln('/// Generated UiPlaygroundVariant for $className');
    buffer.writeln(
      'class $variantClassName extends UiPlaygroundVariant<$inputsClassName> {',
    );
    buffer.writeln('  @override');
    buffer.writeln("  String get title => 'Default';");
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln(
      '  Widget build(BuildContext context, $inputsClassName inputs) {',
    );
    buffer.writeln('    return $className(');
    for (final param in parameters) {
      buffer.writeln('      ${param.name}: ${_generateInputAccess(param)},');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  $inputsClassName inputs() => $inputsClassName();');
    buffer.writeln('}');
    buffer.writeln();

    // Generate Inputs class
    buffer.writeln('/// Generated UiPlaygroundInputs for $className');
    buffer.writeln('class $inputsClassName extends UiPlaygroundInputs {');

    // Generate input fields
    for (final param in parameters) {
      buffer.writeln(_generateInputField(param));
    }

    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln(
      '  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [',
    );
    for (final param in parameters) {
      buffer.writeln('    ${param.name},');
    }
    buffer.writeln('  ];');
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateInputAccess(AnalyzedParameter param) {
    switch (param.inputType) {
      case InputType.string:
        return 'inputs.${param.name}.value ?? ${_getDefaultValue(param)}';
      case InputType.boolean:
        return 'inputs.${param.name}.value ?? ${_getDefaultValue(param)}';
      case InputType.int:
        return 'inputs.${param.name}.value ?? ${_getDefaultValue(param)}';
      case InputType.double:
        return 'inputs.${param.name}.value ?? ${_getDefaultValue(param)}';
      case InputType.enumType:
        return 'inputs.${param.name}.value ?? ${_getDefaultValue(param)}';
      case InputType.color:
        return 'inputs.${param.name}.value ?? ${_getDefaultValue(param)}';
      case InputType.dateTime:
        return 'inputs.${param.name}.value ?? ${_getDefaultValue(param)}';
      case InputType.unsupported:
        return _getDefaultValue(param);
    }
  }

  String _getDefaultValue(AnalyzedParameter param) {
    if (param.defaultValue != null) {
      return param.defaultValue!;
    }
    if (param.isNullable) {
      return 'null';
    }
    switch (param.inputType) {
      case InputType.string:
        return "''";
      case InputType.boolean:
        return 'false';
      case InputType.int:
        return '0';
      case InputType.double:
        return '0.0';
      case InputType.enumType:
        return '${param.typeName}.values.first';
      case InputType.color:
        return 'const Color(0xFF000000)';
      case InputType.dateTime:
        return 'DateTime.now()';
      case InputType.unsupported:
        return 'null';
    }
  }

  String _generateInputField(AnalyzedParameter param) {
    final label = _formatLabel(param.name);

    switch (param.inputType) {
      case InputType.string:
        final defaultVal =
            param.defaultValue ??
            (param.isNullable ? 'null' : "'{${param.name}}'");
        return "  final ${param.name} = UiPlaygroundStringInput(\n    '$label',\n    initialValue: $defaultVal,\n  );";
      case InputType.boolean:
        final defaultVal =
            param.defaultValue ?? (param.isNullable ? 'null' : 'false');
        return "  final ${param.name} = UiPlaygroundBooleanInput(\n    '$label',\n    initialValue: $defaultVal,\n  );";
      case InputType.int:
        final defaultVal =
            param.defaultValue ?? (param.isNullable ? 'null' : '0');
        return "  final ${param.name} = UiPlaygroundIntInput(\n    '$label',\n    initialValue: $defaultVal,\n  );";
      case InputType.double:
        final defaultVal =
            param.defaultValue ?? (param.isNullable ? 'null' : '0.0');
        return "  final ${param.name} = UiPlaygroundDoubleInput(\n    '$label',\n    initialValue: $defaultVal,\n  );";
      case InputType.enumType:
        final defaultVal =
            param.defaultValue ?? '${param.typeName}.values.first';
        return "  final ${param.name} = UiPlaygroundEnumInput<${param.typeName}>(\n    '$label',\n    initialValue: $defaultVal,\n    options: ${param.typeName}.values,\n  );";
      case InputType.color:
        final defaultVal =
            param.defaultValue ??
            (param.isNullable ? 'null' : 'const Color(0xFF000000)');
        return "  final ${param.name} = UiPlaygroundColorInput(\n    '$label',\n    initialValue: $defaultVal,\n  );";
      case InputType.dateTime:
        final defaultVal =
            param.defaultValue ??
            (param.isNullable ? 'null' : 'DateTime.now()');
        return "  final ${param.name} = UiPlaygroundDateTimeInput(\n    '$label',\n    initialValue: $defaultVal,\n  );";
      case InputType.unsupported:
        return '  // Unsupported type for parameter: ${param.name} (${param.typeName})';
    }
  }

  String _formatLabel(String name) {
    // Convert camelCase to Title Case with spaces
    final formatted = name.replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]'),
      (match) => ' ${match.group(0)}',
    );
    return formatted[0].toUpperCase() + formatted.substring(1);
  }
}
