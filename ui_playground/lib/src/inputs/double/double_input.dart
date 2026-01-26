import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundDoubleInput extends UiPlaygroundInputItem<double> {
  final double? min;
  final double? max;

  @override
  double? get defaultValue => 0.0;

  UiPlaygroundDoubleInput(
    super.label, {
    super.initialValue,
    super.extraInfo,
    this.min,
    this.max,
  });

  @override
  void updateState(double? value) {
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

  void toggle(double value) {
    if (this.value == value) {
      updateState(null);
    } else {
      updateState(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ImpaktfullUiNumberInput<double>(
        value: value ?? 0.0,
        onChanged: (value) => updateState(value),
      ),
    );
  }
}
