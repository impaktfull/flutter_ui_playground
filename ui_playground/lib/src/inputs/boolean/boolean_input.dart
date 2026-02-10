import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundBooleanInput extends UiPlaygroundInputItem<bool> {
  @override
  bool? get defaultValue => isNullable ? null : false;

  UiPlaygroundBooleanInput(
    super.label, {
    required super.isNullable,
    super.initialValue,
    super.extraInfo,
  });

  void toggle() {
    final value = this.value;
    bool? newValue;
    if (isNullable) {
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
    if (isNullable) {
      return ImpaktfullUiCheckBox.indermediate(
        value: valueOrDefault,
        onChanged: updateState,
      );
    }
    return ImpaktfullUiCheckBox(
      value: valueOrDefaultRequired,
      onChanged: updateState,
    );
  }
}
