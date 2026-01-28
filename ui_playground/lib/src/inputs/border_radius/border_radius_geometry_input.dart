import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundBorderRadiusGeometryInput
    extends UiPlaygroundInputItem<BorderRadiusGeometry> {
  final List<BorderRadiusGeometry> options;

  @override
  BorderRadiusGeometry? get defaultValue => BorderRadiusGeometry.zero;

  UiPlaygroundBorderRadiusGeometryInput(
    super.label, {
    this.options = const [
      BorderRadiusGeometry.all(Radius.circular(2)),
      BorderRadiusGeometry.all(Radius.circular(4)),
      BorderRadiusGeometry.all(Radius.circular(8)),
      BorderRadiusGeometry.all(Radius.circular(12)),
      BorderRadiusGeometry.all(Radius.circular(16)),
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
