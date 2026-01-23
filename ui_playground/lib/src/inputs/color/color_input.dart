import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundColorInput extends UiPlaygroundInputItem<Color> {
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
