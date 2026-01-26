import 'package:ui_playground_generator/src/parameter_analyzer.dart';
import 'package:ui_playground_generator/src/util/extensions/input_type_extensions.dart';
import 'package:ui_playground_generator/src/writor/input/input_util_writor.dart';

class InputFieldWritor {
  static final Map<InputType, String> _inputTypeToClass = {
    InputType.string: 'UiPlaygroundStringInput',
    InputType.boolean: 'UiPlaygroundBooleanInput',
    InputType.int: 'UiPlaygroundIntInput',
    InputType.double: 'UiPlaygroundDoubleInput',
    InputType.color: 'UiPlaygroundColorInput',
    InputType.dateTime: 'UiPlaygroundDateTimeInput',
    InputType.edgeInsets: 'UiPlaygroundEdgeInsetInput',
    InputType.edgeInsetsGeometry: 'UiPlaygroundEdgeInsetGeometryInput',
  };

  static String generateInputField(AnalyzedParameter param) {
    // Handle custom inputs first
    if (param.customInput != null) {
      return InputUtilWritor.writeInput(
        param: param,
        inputTypeClass: param.customInput!.inputClass,
      );
    }
    final inputType = param.inputType;
    if (inputType == null) {
      return '  // Unsupported input type: ${param.typeName}';
    }

    if (inputType.isEnum) {
      return InputUtilWritor.writeInput(
        param: param,
        inputTypeClass: 'UiPlaygroundEnumInput<${param.typeName}>',
        options: '${param.typeName}.values',
      );
    }
    final inputTypeClass = _inputTypeToClass.getInputTypeClass(inputType);
    if (inputTypeClass != null) {
      return InputUtilWritor.writeInput(
        param: param,
        inputTypeClass: inputTypeClass,
      );
    }
    throw UnimplementedError(
      'Unsupported input type: ${param.inputType?.name}',
    );
  }
}
