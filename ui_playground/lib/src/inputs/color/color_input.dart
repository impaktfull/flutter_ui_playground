import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';
import 'package:ui_playground/src/theme/theme.dart';

class UiPlaygroundColorInput extends UiPlaygroundInputItem<Color> {
  @override
  Color? get defaultValue => UiPlaygroundTheme.accentColor;

  UiPlaygroundColorInput(
    super.label, {
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiCard(
      width: double.infinity,
      child: ImpaktfullUiColorPicker(
        selectedColor: value,
        showActiveColor: true,
        allowedColors: [
          theme.colors.accent,
          ...ImpaktfullUiColorPicker.defaultColors,
        ],
        onColorChanged: updateState,
      ),
    );
  }
}
