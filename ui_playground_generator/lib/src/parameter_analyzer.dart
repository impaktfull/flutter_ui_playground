import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:ui_playground_generator/src/util/type/type_util.dart';

/// Exception thrown when trying to exclude a required parameter.
class InvalidExcludeParamException implements Exception {
  final String paramName;
  final String message;

  InvalidExcludeParamException({
    required this.paramName,
    required this.message,
  });

  @override
  String toString() => 'InvalidExcludeParamException: $message';
}

/// Represents the type of input to generate for a parameter.
class InputType {
  static const InputType string = InputType(name: 'String');
  static const InputType boolean = InputType(name: 'Boolean');
  static const InputType int = InputType(name: 'Int');
  static const InputType double = InputType(name: 'Double');
  static const InputType color = InputType(name: 'Color');
  static const InputType dateTime = InputType(name: 'DateTime');
  static const InputType edgeInsets = InputType(name: 'EdgeInsets');
  static const InputType edgeInsetsGeometry = InputType(
    name: 'EdgeInsetsGeometry',
  );
  static const InputType impaktfullUiAsset = InputType(
    name: 'ImpaktfullUiAsset',
  );
  static const InputType borderRadiusGeometry = InputType(
    name: 'BorderRadiusGeometry',
  );
  static const InputType borderRadius = InputType(
    name: 'BorderRadius',
  );
  static const InputType widget = InputType(name: 'Widget');
  static const InputType custom = InputType(name: 'Custom');

  final String name;
  final bool isEnum;
  final bool isList;

  /// For list types, this is the inner element type.
  final InputType? listElementType;

  const InputType({
    required this.name,
    this.isEnum = false,
    this.isList = false,
    this.listElementType,
  });
}

/// Configuration for a custom input, parsed from the annotation.
class CustomInputConfig {
  final String inputClass;

  /// The library URI for importing this input class.
  final String? importUri;

  const CustomInputConfig({
    required this.inputClass,
    this.importUri,
  });
}

/// Represents an analyzed constructor parameter with its input mapping.
class AnalyzedParameter {
  final String name;
  final String? documentationComment;
  final String typeName;
  final InputType? inputType;
  final bool isNullable;
  final bool isRequired;
  final String? defaultValue;
  final DartType dartType;

  /// Custom input configuration if specified via annotation.
  final CustomInputConfig? customInput;

  /// For list types, the name of the element type (e.g., 'String' for `List<String>`).
  final String? listElementTypeName;

  /// For list types, custom input for the element type if specified.
  final CustomInputConfig? listElementCustomInput;

  AnalyzedParameter({
    required this.name,
    required this.documentationComment,
    required this.typeName,
    required this.isNullable,
    required this.isRequired,
    required this.dartType,
    this.defaultValue,
    this.inputType,
    this.customInput,
    this.listElementTypeName,
    this.listElementCustomInput,
  });
}

/// Analyzes constructor parameters and maps them to UiPlayground input types.
class ParameterAnalyzer {
  /// Analyzes a list of parameters and returns their input mappings.
  ///
  /// [customInputs] is a map of type names to custom input configurations
  /// for this specific component. These take precedence over [globalCustomInputs].
  ///
  /// [globalCustomInputs] is a map of type names to custom input configurations
  /// that apply globally to all components.
  ///
  /// Both maps are keyed by **type name** (e.g., 'EdgeInsets', 'Alignment').
  ///
  /// Throws [InvalidExcludeParamException] if any parameter in [excludeParams]
  /// is a required parameter (required parameters cannot be excluded).
  static List<AnalyzedParameter> analyze(
    List<FormalParameterElement> parameters, {
    List<String> excludeParams = const [],
    Map<String, CustomInputConfig> customInputs = const {},
    Map<String, CustomInputConfig> globalCustomInputs = const {},
  }) {
    // Validate that no required parameters are being excluded
    _validateExcludeParams(parameters, excludeParams);

    final result = <AnalyzedParameter>[];

    for (final param in parameters) {
      // Skip excluded parameters
      if (excludeParams.contains(param.name)) {
        continue;
      }

      // Determine custom input by type name: per-component takes precedence over global
      final typeName = _getTypeName(param.type);
      final customInput =
          customInputs[typeName] ?? globalCustomInputs[typeName];

      // Skip function types (callbacks) unless custom input is specified
      if (param.type is FunctionType && customInput == null) {
        continue;
      }

      // Skip types that extend ImpaktfullUiComponentTheme (theme override parameters)
      if (TypeUtil.extendsImpaktfullUiComponentTheme(
        param.type,
        'ImpaktfullUiComponentTheme',
      )) {
        continue;
      }

      final analyzed = _analyzeParameter(
        param,
        customInput: customInput,
        customInputs: customInputs,
        globalCustomInputs: globalCustomInputs,
      );
      if (analyzed != null) {
        result.add(analyzed);
      }
    }

    return result;
  }

  /// Validates that no required parameters are being excluded.
  static void _validateExcludeParams(
    List<FormalParameterElement> parameters,
    List<String> excludeParams,
  ) {
    for (final param in parameters) {
      final paramName = param.name;
      if (paramName == null || paramName.isEmpty) continue;

      if (excludeParams.contains(paramName) && param.isRequired) {
        throw InvalidExcludeParamException(
          paramName: paramName,
          message:
              "Cannot exclude required parameter '$paramName'. "
              'Only optional parameters can be excluded via excludeParams.',
        );
      }
    }
  }

  static AnalyzedParameter? _analyzeParameter(
    FormalParameterElement param, {
    CustomInputConfig? customInput,
    Map<String, CustomInputConfig> customInputs = const {},
    Map<String, CustomInputConfig> globalCustomInputs = const {},
  }) {
    final paramName = param.name;
    if (paramName == null || paramName.isEmpty) {
      return null;
    }

    final type = param.type;
    final isNullable = type.nullabilitySuffix == NullabilitySuffix.question;
    final typeName = _getTypeName(type);

    // Get default value if present
    String? defaultValue;
    if (param.hasDefaultValue && param.defaultValueCode != null) {
      defaultValue = param.defaultValueCode;
    }

    // Check for list types
    String? listElementTypeName;
    CustomInputConfig? listElementCustomInput;

    if (type.isDartCoreList && type is InterfaceType) {
      final typeArgs = type.typeArguments;
      if (typeArgs.isNotEmpty) {
        final elementType = typeArgs.first;
        listElementTypeName = _getTypeName(elementType);
        // Check if there's a custom input for the element type
        listElementCustomInput =
            customInputs[listElementTypeName] ??
            globalCustomInputs[listElementTypeName];
      }
    }

    // If custom input is specified, use it; otherwise map to default input type
    final InputType? inputType;
    if (customInput != null) {
      inputType = InputType.custom;
    } else {
      inputType = _mapToInputType(
        type,
        customInputs: customInputs,
        globalCustomInputs: globalCustomInputs,
      );
    }

    return AnalyzedParameter(
      name: paramName,
      typeName: typeName,
      documentationComment: param.documentationComment,
      inputType: inputType,
      isNullable: isNullable,
      isRequired: param.isRequired,
      defaultValue: defaultValue,
      dartType: type,
      customInput: customInput,
      listElementTypeName: listElementTypeName,
      listElementCustomInput: listElementCustomInput,
    );
  }

  static String _getTypeName(DartType type) {
    // Remove nullability suffix for type name
    final element = type.element;
    if (element != null) {
      return element.name ?? type.getDisplayString();
    }
    return type.getDisplayString();
  }

  static InputType? _mapToInputType(
    DartType type, {
    Map<String, CustomInputConfig> customInputs = const {},
    Map<String, CustomInputConfig> globalCustomInputs = const {},
  }) {
    final element = type.element;
    final typeName = _getTypeName(type);

    // Check for basic types
    if (type.isDartCoreString) {
      return InputType.string;
    }
    if (type.isDartCoreBool) {
      return InputType.boolean;
    }
    if (type.isDartCoreInt) {
      return InputType.int;
    }
    if (type.isDartCoreDouble || type.isDartCoreNum) {
      return InputType.double;
    }

    if (element is EnumElement) {
      return InputType(
        name: typeName,
        isEnum: true,
      );
    }

    // Handle List<T> types
    if (type.isDartCoreList && type is InterfaceType) {
      final typeArgs = type.typeArguments;
      if (typeArgs.isNotEmpty) {
        final elementType = typeArgs.first;
        final elementTypeName = _getTypeName(elementType);

        // Check if there's a custom input for the element type
        final elementCustomInput =
            customInputs[elementTypeName] ??
            globalCustomInputs[elementTypeName];

        InputType? elementInputType;
        if (elementCustomInput != null) {
          elementInputType = InputType.custom;
        } else {
          // Recursively map the element type (but don't pass custom inputs to avoid infinite recursion)
          elementInputType = _mapToInputType(elementType);
        }

        if (elementInputType != null) {
          return InputType(
            name: 'List<$elementTypeName>',
            isList: true,
            listElementType: elementInputType,
          );
        }
      }
      return null;
    }

    return InputType(
      name: typeName,
    );
  }
}
