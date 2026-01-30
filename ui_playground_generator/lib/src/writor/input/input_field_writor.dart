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
    InputType.edgeInsets: 'UiPlaygroundEdgeInsetsInput',
    InputType.edgeInsetsGeometry: 'UiPlaygroundEdgeInsetsGeometryInput',
    InputType.borderRadiusGeometry: 'UiPlaygroundBorderRadiusGeometryInput',
    InputType.borderRadius: 'UiPlaygroundBorderRadiusInput',
    InputType.duration: 'UiPlaygroundDurationInput',
    InputType.impaktfullUiAsset: 'UiPlaygroundImpaktfullUiAssetInput',
    InputType.widget: 'UiPlaygroundWidgetInput',
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

    // Handle list types
    if (inputType.isList) {
      return _generateListInput(param, inputType);
    }

    // Handle callback types
    if (inputType.isCallback) {
      return _generateCallbackInput(param);
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

  static String _generateCallbackInput(AnalyzedParameter param) {
    return InputUtilWritor.writeCallbackInput(param: param);
  }

  static String _generateListInput(
    AnalyzedParameter param,
    InputType inputType,
  ) {
    final elementTypeName = param.listElementTypeName;
    if (elementTypeName == null) {
      return '  // Unsupported list type: ${param.typeName}';
    }

    final elementType = inputType.listElementType;
    if (elementType == null) {
      return '  // Unsupported list element type: $elementTypeName';
    }

    // Determine the input builder for the element type
    String inputBuilder;
    if (param.listElementCustomInput != null) {
      // Custom input for the element type
      inputBuilder = '(label) => ${param.listElementCustomInput!.inputClass}(label, isNullable: ${param.isNullable})';
    } else if (elementType.isEnum) {
      // Enum type
      inputBuilder =
          '(label) => UiPlaygroundEnumInput<$elementTypeName>(label, isNullable: ${param.isNullable}, options: $elementTypeName.values)';
    } else {
      // Standard input type
      final elementInputClass = _inputTypeToClass.getInputTypeClass(
        elementType,
      );
      if (elementInputClass == null) {
        return '  // Unsupported list element type: $elementTypeName';
      }
      inputBuilder = '(label) => $elementInputClass(label, isNullable: ${param.isNullable})';
    }

    return InputUtilWritor.writeListInput(
      param: param,
      elementTypeName: elementTypeName,
      inputBuilder: inputBuilder,
    );
  }
}
