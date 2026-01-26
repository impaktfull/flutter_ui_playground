import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';

@UiPlaygroundComponent(
  title: 'Button',
)
class Button extends StatelessWidget {
  /// The title of the button.
  final String title;

  /// The callback to be called when the button is tapped.
  final VoidCallback onTap;

  const Button({
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiButton(
      title: title,
      type: ImpaktfullUiButtonType.primary,
      onTap: onTap,
    );
  }
}
