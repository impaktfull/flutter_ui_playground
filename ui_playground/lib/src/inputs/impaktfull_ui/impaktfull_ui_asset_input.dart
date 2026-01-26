import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/inputs/icon/icons_data.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundImpaktfullUiAssetInput
    extends UiPlaygroundInputItem<ImpaktfullUiAsset> {
  @override
  ImpaktfullUiAsset? get defaultValue => null;

  final _controller = ImpaktfullUiDropdownController();
  final items = AllIcons.allFlatIconsAsMap.values
      .map(
        (e) => ImpaktfullUiDropdownItem(
          label: e.hashCode.toString(),
          value: ImpaktfullUiAsset.icon(e),
        ),
      )
      .toList();

  UiPlaygroundImpaktfullUiAssetInput(
    super.label, {
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
            leadingAsset: value,
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
                  child: ImpaktfullUiAssetWidget(
                    asset: item.value,
                  ),
                ),
              ),
          noDataLabel: 'No icons',
        ),
      ),
    );
  }
}
