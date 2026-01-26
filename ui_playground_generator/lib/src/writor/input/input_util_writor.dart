import 'package:ui_playground_generator/src/util/extensions/case_extensions.dart';
import 'package:ui_playground_generator/ui_playground_generator.dart';

class InputUtilWritor {
  static String writeInput({
    required AnalyzedParameter param,
    required String inputTypeClass,
    String? options,
  }) {
    final defaultValue = param.defaultValue;
    final label = param.name.toTitleCase();
    final sb = StringBuffer();
    sb.write("  final ${param.name} = $inputTypeClass(\n");
    sb.write("    '$label',\n");
    if (defaultValue != null) {
      sb.write("    initialValue: $defaultValue,\n");
    }
    if (options != null) {
      sb.write("    options: $options,\n");
    }
    sb.write("  );");
    return sb.toString();
  }

  static String getValue(AnalyzedParameter param) {
    if (param.isNullable) {
      return 'inputs.${param.name}.valueOrDefault';
    }
    return 'inputs.${param.name}.valueOrDefaultRequired';
  }

  static String writeListInput({
    required AnalyzedParameter param,
    required String elementTypeName,
    required String inputBuilder,
  }) {
    final defaultValue = param.defaultValue;
    final label = param.name.toTitleCase();
    final sb = StringBuffer();
    sb.write(
      "  final ${param.name} = UiPlaygroundListInput<$elementTypeName>(\n",
    );
    sb.write("    '$label',\n");
    sb.write("    inputBuilder: $inputBuilder,\n");
    if (defaultValue != null) {
      sb.write("    initialValue: $defaultValue,\n");
    }
    sb.write("  );");
    return sb.toString();
  }
}
