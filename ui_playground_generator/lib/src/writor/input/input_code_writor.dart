import 'package:ui_playground_generator/src/parameter_analyzer.dart';
import 'package:ui_playground_generator/src/writor/input/input_field_writor.dart';
import 'package:ui_playground_generator/src/writor/input/input_util_writor.dart';

class InputCodeWritor {
  /// Parameters that should always come last in the generated code.
  /// `child` comes before `children` (both at the end).
  static const _lastParams = ['child', 'children'];

  /// Sorts parameters so that `child` and `children` come last.
  static List<AnalyzedParameter> _sortParameters(
    List<AnalyzedParameter> parameters,
  ) {
    final sorted = List<AnalyzedParameter>.from(parameters);
    sorted.sort((a, b) {
      final aIndex = _lastParams.indexOf(a.name);
      final bIndex = _lastParams.indexOf(b.name);

      // Both are special params - sort by their order in _lastParams
      if (aIndex != -1 && bIndex != -1) {
        return aIndex.compareTo(bIndex);
      }
      // Only a is special - it goes last
      if (aIndex != -1) return 1;
      // Only b is special - it goes last
      if (bIndex != -1) return -1;
      // Neither is special - maintain original order
      return 0;
    });
    return sorted;
  }

  static String generateCode({
    required String className,
    required String title,
    required List<AnalyzedParameter> parameters,
  }) {
    final itemClassName = '${className}PlaygroundItem';
    final variantClassName = '${className}PlaygroundVariant';
    final inputsClassName = '${className}PlaygroundInputs';

    // Sort parameters so child/children come last
    final sortedParameters = _sortParameters(parameters);

    final buffer = StringBuffer();

    // Item class
    buffer.writeln(
      '// **************************************************************************',
    );
    buffer.writeln('// $className');
    buffer.writeln(
      '// **************************************************************************',
    );
    buffer.writeln();
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

    // Variant class
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
    for (final param in sortedParameters) {
      final value = InputUtilWritor.getValue(param);
      buffer.writeln('      ${param.name}: $value,');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.writeln('  $inputsClassName inputs() => $inputsClassName();');
    buffer.writeln('}');
    buffer.writeln();

    // Inputs class
    buffer.writeln('class $inputsClassName extends UiPlaygroundInputs {');
    for (final param in parameters) {
      buffer.writeln(InputFieldWritor.generateInputField(param));
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
}
