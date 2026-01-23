import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

/// Represents the type of input to generate for a parameter.
class InputType {
  final String name;
  final bool isEnum;

  const InputType({
    required this.name,
    this.isEnum = false,
  });

  static const InputType string = InputType(name: 'String');
  static const InputType boolean = InputType(name: 'Boolean');
  static const InputType int = InputType(name: 'Int');
  static const InputType double = InputType(name: 'Double');
  static const InputType color = InputType(name: 'Color');
  static const InputType dateTime = InputType(name: 'DateTime');
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

  AnalyzedParameter({
    required this.name,
    required this.documentationComment,
    required this.typeName,
    required this.isNullable,
    required this.isRequired,
    required this.dartType,
    this.defaultValue,
    this.inputType,
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
      documentationComment: param.documentationComment,
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

  static InputType? _mapToInputType(DartType type) {
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

    // Check for Color (from dart:ui or Flutter)
    if (typeName == 'Color') {
      return InputType.color;
    }

    if (typeName == 'DateTime') {
      return InputType.dateTime;
    }

    if (element is EnumElement) {
      return InputType(
        name: typeName,
        isEnum: true,
      );
    }
    return null;
  }
}
