import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundBorderRadiusInput
    extends UiPlaygroundInputItem<BorderRadius> {
  final List<BorderRadius> options;

  @override
  BorderRadius? get defaultValue => BorderRadius.zero;

  UiPlaygroundBorderRadiusInput(
    super.label, {
    this.options = const [
      BorderRadius.all(Radius.circular(2)),
      BorderRadius.all(Radius.circular(4)),
      BorderRadius.all(Radius.circular(8)),
      BorderRadius.all(Radius.circular(12)),
      BorderRadius.all(Radius.circular(16)),
    ],
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ImpaktfullUiSeparatedColumn(
        children: [
          for (final item in options) ...[
            ImpaktfullUiRadioButtonListItem<BorderRadius?>(
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
