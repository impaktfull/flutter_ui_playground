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
    sb.write("    isNullable: ${param.isNullable},\n");
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
    // Handle callback types - generate inline callback with notification
    if (param.inputType?.isCallback == true && param.functionTypeInfo != null) {
      return _generateCallbackValue(param);
    }

    if (param.isNullable) {
      return 'inputs.${param.name}.valueOrDefault';
    }
    return 'inputs.${param.name}.valueOrDefaultRequired';
  }

  /// Generates the callback value that shows a notification when triggered.
  static String _generateCallbackValue(AnalyzedParameter param) {
    final funcInfo = param.functionTypeInfo!;
    final paramName = param.name;
    final params = funcInfo.parameters;
    final returnType = funcInfo.returnTypeName;

    // Build the parameter list for the lambda
    final paramList = params.isEmpty ? '' : params.map((p) => p.name).join(', ');

    // Build the notification message with parameter values
    String message;
    if (params.isEmpty) {
      message = '$paramName()';
    } else {
      final paramValues = params.map((p) => '${p.name}: \$${p.name}').join(', ');
      message = '$paramName($paramValues)';
    }

    // Check if the return type requires special handling
    final isAsyncVoid = returnType == 'Future<void>';
    final isFuture = returnType.startsWith('Future<');
    final isWidget = returnType == 'Widget' || returnType == 'Widget?';

    // Widget builders should return null (for nullable) or skip notification
    if (isWidget) {
      // Return null for widget builders - we can't show a notification and return a widget
      return '($paramList) => null';
    }

    // Async callbacks need to use async syntax
    if (isAsyncVoid) {
      return "($paramList) async => UiPlaygroundNotification.show(context, '$message')";
    }

    // Other Future types (like Future<T>) - wrap in async and return notification result
    if (isFuture) {
      return "($paramList) async => UiPlaygroundNotification.show(context, '$message')";
    }

    return "($paramList) => UiPlaygroundNotification.show(context, '$message')";
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
    sb.write("    isNullable: ${param.isNullable},\n");
    sb.write("    inputBuilder: $inputBuilder,\n");
    if (defaultValue != null) {
      sb.write("    initialValue: $defaultValue,\n");
    }
    sb.write("  );");
    return sb.toString();
  }

  static String writeCallbackInput({
    required AnalyzedParameter param,
  }) {
    final label = param.name.toTitleCase();
    final funcInfo = param.functionTypeInfo;

    final sb = StringBuffer();
    sb.write("  final ${param.name} = UiPlaygroundCallbackInput(\n");
    sb.write("    '$label',\n");
    sb.write("    isNullable: ${param.isNullable},\n");
    if (funcInfo != null && funcInfo.parameters.isNotEmpty) {
      final paramNames = funcInfo.parameters.map((p) => "'${p.name}'").join(', ');
      sb.write("    parameterNames: [$paramNames],\n");
    }

    sb.write("  );");
    return sb.toString();
  }
}
