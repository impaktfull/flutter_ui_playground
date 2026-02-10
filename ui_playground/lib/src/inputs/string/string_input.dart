import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundStringInput extends UiPlaygroundInputItem<String> {
  @override
  String? get defaultValue => isNullable ? null : '{$label}';

  UiPlaygroundStringInput(
    super.label, {
    required super.isNullable,
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ImpaktfullUiInputField(
        value: valueOrDefault,
        onChanged: (value) => updateState(value),
      ),
    );
  }

  @override
  void updateState(String? value) {
    if (value== null || value.isEmpty) {
      super.updateState(null);
    } else {
      super.updateState(value);
    }
  }
}
