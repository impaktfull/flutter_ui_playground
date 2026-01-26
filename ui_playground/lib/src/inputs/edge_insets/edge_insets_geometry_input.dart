import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundEdgeInsetsGeometryInput
    extends UiPlaygroundInputItem<EdgeInsetsGeometry> {
  final List<EdgeInsetsGeometry> options;

  @override
  EdgeInsetsGeometry? get defaultValue => EdgeInsets.zero;

  UiPlaygroundEdgeInsetsGeometryInput(
    super.label, {
    this.options = const [
      EdgeInsets.all(2),
      EdgeInsets.all(4),
      EdgeInsets.all(8),
      EdgeInsets.all(12),
      EdgeInsets.all(16),
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
            ImpaktfullUiRadioButtonListItem<EdgeInsetsGeometry?>(
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
