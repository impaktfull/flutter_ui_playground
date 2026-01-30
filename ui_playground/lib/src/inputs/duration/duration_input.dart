import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundDurationInput extends UiPlaygroundInputItem<Duration> {
  final List<Duration> options;

  @override
  Duration? get defaultValue => Duration.zero;

  UiPlaygroundDurationInput(
    super.label, {
    required super.isNullable,
    this.options = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
      Duration(seconds: 5),
      Duration(seconds: 10),
      Duration(seconds: 20),
      Duration(seconds: 30),
      Duration(minutes: 1),
      Duration(minutes: 10),
      Duration(minutes: 30),
      Duration(hours: 1),
      Duration(hours: 1, minutes: 30),
      Duration(hours: 2),
      Duration(hours: 24),
    ],
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ImpaktfullUiSeparatedColumn(
        children: [
          if (isNullable) ...[
            ImpaktfullUiRadioButtonListItem(
              title: 'null',
              value: null,
              groupValue: value,
              onChanged: updateState,
            ),
          ],
          for (final item in options) ...[
            ImpaktfullUiRadioButtonListItem(
              title: item.toString(),
              value: item,
              groupValue: value,
              onChanged: updateState,
            ),
          ],
        ],
      ),
    );
  }
}
