import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

/// Represents the type of input to generate for a parameter.
enum InputType {
  string,
  boolean,
  int,
  double,
  enumType,
  color,
  dateTime,
  unsupported,
}

/// Represents an analyzed constructor parameter with its input mapping.
class AnalyzedParameter {
  final String name;
  final String typeName;
  final InputType inputType;
  final bool isNullable;
  final bool isRequired;
  final String? defaultValue;
  final DartType dartType;

  AnalyzedParameter({
    required this.name,
    required this.typeName,
    required this.inputType,
    required this.isNullable,
    required this.isRequired,
    this.defaultValue,
    required this.dartType,
  });
}

/// Analyzes constructor parameters and maps them to UiPlayground input types.
class ParameterAnalyzer {
  /// Analyzes a list of parameters and returns their input mappings.
  static List<AnalyzedParameter> analyze(
    List<FormalParameterElement> parameters, {
    List<String> excludeParams = const [],
  }) {
    final result = <AnalyzedParameter>[];

    for (final param in parameters) {
      // Skip excluded parameters
      if (excludeParams.contains(param.name)) {
        continue;
      }

      // Skip function types (callbacks)
      if (param.type is FunctionType) {
        continue;
      }

      final analyzed = _analyzeParameter(param);
      if (analyzed != null) {
        result.add(analyzed);
      }
    }

    return result;
  }

  static AnalyzedParameter? _analyzeParameter(FormalParameterElement param) {
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

    final inputType = _mapToInputType(type);

    return AnalyzedParameter(
      name: paramName,
      typeName: typeName,
      inputType: inputType,
      isNullable: isNullable,
      isRequired: param.isRequired,
      defaultValue: defaultValue,
      dartType: type,
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

  static InputType _mapToInputType(DartType type) {
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
    if (type.isDartCoreDouble) {
      return InputType.double;
    }

    // Check for Color (from dart:ui or Flutter)
    if (typeName == 'Color') {
      return InputType.color;
    }

    // Check for DateTime
    if (typeName == 'DateTime') {
      return InputType.dateTime;
    }

    // Check for enum types
    if (element is EnumElement) {
      return InputType.enumType;
    }

    return InputType.unsupported;
  }
}
