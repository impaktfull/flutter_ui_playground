import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundBooleanInput extends UiPlaygroundInputItem<bool> {
  final bool allowNull;

  UiPlaygroundBooleanInput(
    super.label, {
    super.initialValue,
    super.extraInfo,
    this.allowNull = false,
  });

  void toggle() {
    final value = this.value;
    bool? newValue;
    if (allowNull) {
      if (value == true) {
        newValue = null;
      } else if (value == false) {
        newValue = true;
      } else {
        newValue = false;
      }
    } else {
      if (value == null) return;
      newValue = !value;
    }
    updateState(newValue);
  }

  @override
  Widget build(BuildContext context) {
    if (allowNull) {
      return ImpaktfullUiCheckBox.indermediate(
        value: value,
        onChanged: updateState,
      );
    }
    return ImpaktfullUiCheckBox(
      value: value ?? false,
      onChanged: updateState,
    );
  }
}
