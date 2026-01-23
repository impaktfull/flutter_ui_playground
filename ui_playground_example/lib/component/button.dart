import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';

part 'button.g.dart';

@UiPlaygroundComponent(
  title: 'Button',
)
class Button extends StatelessWidget {
  final String title;

  const Button({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiButton(
      title: title,
      type: ImpaktfullUiButtonType.primary,
      onTap: () {},
    );
  }
}
