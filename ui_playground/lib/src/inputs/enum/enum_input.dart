import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundEnumInput<T extends Enum> extends UiPlaygroundInputItem<T> {
  final List<T> options;

  @override
  T? get defaultValue => options.first;

  UiPlaygroundEnumInput(
    super.label, {
    required super.isNullable,
    required this.options,
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
              title: item.name,
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
