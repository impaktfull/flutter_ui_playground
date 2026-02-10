import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundIntInput extends UiPlaygroundInputItem<int> {
  final int? min;
  final int? max;

  @override
  int get defaultValue => 0;

  UiPlaygroundIntInput(
    super.label, {
    required super.isNullable,
    super.initialValue,
    super.extraInfo,
    this.min,
    this.max,
  });

  @override
  void updateState(int? value) {
    final min = this.min;
    final max = this.max;
    if (min == null && max == null) {
      super.updateState(value);
      return;
    }
    if (value == null) {
      super.updateState(null);
      return;
    }
    if (min != null && value < min) {
      super.updateState(min);
      return;
    }
    if (max != null && value > max) {
      super.updateState(max);
      return;
    }
    super.updateState(value);
  }

  void toggle(int value) {
    if (this.value == value) {
      updateState(null);
    } else {
      updateState(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ImpaktfullUiNumberInput<int>(
        value: valueOrDefault ?? 0,
        onChanged: (value) => updateState(value),
      ),
    );
  }
}
