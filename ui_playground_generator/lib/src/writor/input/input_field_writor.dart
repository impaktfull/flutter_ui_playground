import 'package:ui_playground_generator/src/parameter_analyzer.dart';
import 'package:ui_playground_generator/src/writor/input/input_util_writor.dart';

class InputFieldWritor {
  static String generateInputField(AnalyzedParameter param) {
    if (param.inputType?.isEnum == true) {
      return InputUtilWritor.writeInput(
        param: param,
        inputType: 'UiPlaygroundEnumInput<${param.typeName}>',
        options: '${param.typeName}.values',
      );
    }
    switch (param.inputType) {
      case InputType.string:
        return InputUtilWritor.writeInput(
          param: param,
          inputType: 'UiPlaygroundStringInput',
        );
      case InputType.boolean:
        return InputUtilWritor.writeInput(
          param: param,
          inputType: 'UiPlaygroundBooleanInput',
        );
      case InputType.int:
        return InputUtilWritor.writeInput(
          param: param,
          inputType: 'UiPlaygroundIntInput',
        );
      case InputType.double:
        return InputUtilWritor.writeInput(
          param: param,
          inputType: 'UiPlaygroundDoubleInput',
        );
      case InputType.color:
        return InputUtilWritor.writeInput(
          param: param,
          inputType: 'UiPlaygroundColorInput',
        );
      case InputType.dateTime:
        return InputUtilWritor.writeInput(
          param: param,
          inputType: 'UiPlaygroundDateTimeInput',
        );
      case null:
        return ' // Unsupported input type: ${param.typeName}';
      default:
        throw UnimplementedError(
          'Unsupported input type: ${param.inputType?.name}',
        );
    }
  }
}
