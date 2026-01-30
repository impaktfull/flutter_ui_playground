import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/inputs/icon/icons_data.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundImpaktfullUiAssetInput
    extends UiPlaygroundInputItem<ImpaktfullUiAsset> {
  @override
  ImpaktfullUiAsset? get defaultValue => null;

  final _controller = ImpaktfullUiDropdownController();
  List<ImpaktfullUiDropdownItem<ImpaktfullUiAsset?>> get _items => [
    if (isNullable) ...[
      ImpaktfullUiDropdownItem(
        label: 'null',
        value: null,
      ),
    ],
    ...AllIcons.allFlatIconsAsMap.values.map(
      (e) => ImpaktfullUiDropdownItem(
        label: e.hashCode.toString(),
        value: ImpaktfullUiAsset.icon(e),
      ),
    ),
  ];

  UiPlaygroundImpaktfullUiAssetInput(
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
            leadingAsset: value,
            trailingAsset: const ImpaktfullUiAsset.icon(Icons.arrow_drop_down),
            onTap: () => _controller.open(),
          ),
          items: _items,
          itemBuilder: (context, item, index, controller) =>
              ImpaktfullUiTouchFeedback(
                onTap: () {
                  updateState(item.value);
                  _controller.close();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: item.value == null
                      ? Center(
                          child: Text('null'),
                        )
                      : ImpaktfullUiAssetWidget(
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
