import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

/// Input for callback/function parameters.
///
/// This input doesn't provide interactive controls - it serves as a marker
/// for the code generator. The generated callback will show a notification
/// with the function name and arguments when triggered.
class UiPlaygroundCallbackInput extends UiPlaygroundInputItem<Function> {
  /// The names of the callback parameters.
  final List<String> parameterNames;

  @override
  Function? get defaultValue => null;

  UiPlaygroundCallbackInput(
    super.label, {
    required super.isNullable,
    this.parameterNames = const [],
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ImpaktfullUiTheme.of(context);
    final paramInfo = parameterNames.isEmpty ? 'No parameters' : 'Parameters: ${parameterNames.join(', ')}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ImpaktfullUiAutoLayout.horizontal(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app_outlined,
            size: 20,
            color: theme.colors.text,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Callback',
                  style: theme.textStyles.onCard.text.medium,
                ),
                Text(
                  paramInfo,
                  style: theme.textStyles.onCardTertiary.text.extraSmall.light,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
