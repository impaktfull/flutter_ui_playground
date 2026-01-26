import 'package:ui_playground_generator/src/util/extensions/case_extensions.dart';
import 'package:ui_playground_generator/ui_playground_generator.dart';

class InputUtilWritor {
  static String writeInput({
    required AnalyzedParameter param,
    required String inputType,
    String? options,
  }) {
    final defaultValue = param.defaultValue ?? getDefaultValue(param);
    final label = param.name.toTitleCase();
    final sb = StringBuffer();
    sb.write("  final ${param.name} = $inputType(\n");
    sb.write("    '$label',\n");
    sb.write("    initialValue: $defaultValue,\n");
    if (options != null) {
      sb.write("    options: $options,\n");
    }
    sb.write("  );");
    return sb.toString();
  }

  static String getDefaultValue(AnalyzedParameter param) {
    String defaultStringValue() {
      return "'{${param.name}}'";
    }

    if (param.defaultValue != null) {
      return param.defaultValue!;
    }
    if (param.isNullable) {
      if (param.inputType == InputType.string) {
        return defaultStringValue();
      }
      return 'null';
    }
    if (param.inputType?.isEnum == true) {
      return '${param.typeName}.values.first';
    }
    switch (param.inputType) {
      case InputType.string:
        return defaultStringValue();
      case InputType.boolean:
        return 'false';
      case InputType.int:
        return '0';
      case InputType.double:
        return '0.0';
      case InputType.color:
        return 'UiPlaygroundTheme.accentColor';
      case InputType.dateTime:
        return 'DateTime.now()';
      default:
        return 'null';
    }
  }
}
