import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundDateTimeInput extends UiPlaygroundInputItem<DateTime> {
  @override
  DateTime? get defaultValue => DateTime.now();

  UiPlaygroundDateTimeInput(
    super.label, {
    required super.isNullable,
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiCard(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ImpaktfullUiDatePicker(
        selectedDate: value,
        onDateChanged: updateState,
        margin: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
