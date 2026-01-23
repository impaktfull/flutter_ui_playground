import 'package:flutter/widgets.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_item.dart';
import 'package:ui_playground/src/model/item/playground_variant.dart';
import 'package:ui_playground/src/model/playground_section.dart';

typedef PlaygroundVariantSelectedEvent =
    void Function(
      BuildContext context,
      UiPlaygroundSection section,
      UiPlaygroundItem item,
      UiPlaygroundVariant variant,
    );

class UiPlaygroundDrawer extends StatefulWidget {
  final List<UiPlaygroundSection> sections;
  final UiPlaygroundSection? selectedSection;
  final UiPlaygroundItem? selectedItem;
  final UiPlaygroundVariant? selectedVariant;
  final PlaygroundVariantSelectedEvent onVariantSelected;

  const UiPlaygroundDrawer({
    required this.sections,
    required this.selectedSection,
    required this.selectedItem,
    required this.selectedVariant,
    required this.onVariantSelected,
    super.key,
  });

  @override
  State<UiPlaygroundDrawer> createState() => _UiPlaygroundDrawerState();
}

class _UiPlaygroundDrawerState extends State<UiPlaygroundDrawer> {
  var _searchValue = '';

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiSidebarNavigation(
      items: [
        ImpaktfullUiInputField(
          value: _searchValue,
          label: 'Search',
          onChanged: _onSeachChanged,
        ),
        for (final section in widget.sections) ...[
          ..._buildSection(context, section),
        ],
      ],
    );
  }

  List<Widget> _buildSection(
    BuildContext context,
    UiPlaygroundSection section,
  ) {
    final items = section.items;
    final navigationItems = <ImpaktfullUiSidebarNavigationItem>[];
    for (var item in section.items) {
      final filteredVariants = item.variants
          .where(
            (variant) => variant.title.toLowerCase().contains(
              _searchValue.toLowerCase(),
            ),
          )
          .toList();
      if (filteredVariants.isEmpty) continue;
      navigationItems.add(
        ImpaktfullUiSidebarNavigationItem(
          title: item.title,
          isSelected: widget.selectedItem == item,
          items: [
            for (final variant in filteredVariants) ...[
              ImpaktfullUiSidebarNavigationItem(
                title: variant.title,
                isSelected: widget.selectedVariant == variant,
                onTap: () =>
                    widget.onVariantSelected(context, section, item, variant),
              ),
            ],
          ],
        ),
      );
    }
    if (items.length == 1) {
      return navigationItems;
    }
    if (navigationItems.isEmpty) return [];
    return [
      ImpaktfullUiSidebarNavigationItem(
        title: section.title,
        isSelected: widget.selectedSection == section,
        items: navigationItems,
      ),
    ];
  }

  void _onSeachChanged(String value) {
    setState(() => _searchValue = value);
  }
}
