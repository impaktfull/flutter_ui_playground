import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/inputs/icon/icons_data.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundIconInput extends UiPlaygroundInputItem<IconData> {
  @override
  IconData? get defaultValue => AllIcons.allFlatIconsAsMap.values.first;

  final _controller = ImpaktfullUiDropdownController();
  final items = AllIcons.allFlatIconsAsMap.values
      .map(
        (e) => ImpaktfullUiDropdownItem(label: e.hashCode.toString(), value: e),
      )
      .toList();

  UiPlaygroundIconInput(
    super.label, {
    required super.isNullable,
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Center(
        child: ImpaktfullUiDropdown.builder(
          controller: _controller,
          button: (context) => ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.secondary,
            size: ImpaktfullUiButtonSize.extraLarge,
            leadingAsset: value == null ? null : ImpaktfullUiAsset.icon(value!),
            trailingAsset: const ImpaktfullUiAsset.icon(Icons.arrow_drop_down),
            onTap: () => _controller.open(),
          ),
          items: items,
          itemBuilder: (context, item, index, controller) =>
              ImpaktfullUiTouchFeedback(
                onTap: () {
                  updateState(item.value);
                  _controller.close();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Icon(item.value),
                ),
              ),
          noDataLabel: 'No icons',
        ),
      ),
    );
  }
}
