import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';

@UiPlaygroundComponent(
  title: 'Button',
)
class Button extends StatelessWidget {
  /// The title of the button.
  final String title;
  final VoidCallback? onTap;
  final bool fullWidth;

  const Button({
    required this.title,
    required this.onTap,
    this.fullWidth = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiButton(
      title: title,
      fullWidth: fullWidth,
      type: ImpaktfullUiButtonType.primary,
      onTap: onTap,
    );
  }
}
