import 'package:flutter/widgets.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_item.dart';
import 'package:ui_playground/src/model/playground_section.dart';
import 'package:ui_playground/src/model/item/playground_variant.dart';
import 'package:ui_playground/src/widget/home/drawer.dart';
import 'package:ui_playground/src/widget/playground/playground_widget.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final List<UiPlaygroundSection> sections;

  const HomeScreen({
    required this.title,
    required this.sections,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UiPlaygroundSection? selectedSection;
  UiPlaygroundItem? selectedItem;
  UiPlaygroundVariant? selectedVariant;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = ImpaktfullUiResponsiveLayout.isSmallOrSmaller(context);
    final drawer = UiPlaygroundDrawer(
      sections: widget.sections,
      selectedSection: selectedSection,
      selectedItem: selectedItem,
      selectedVariant: selectedVariant,
      onVariantSelected: _onVariantSelected,
    );
    return ImpaktfullUiThemeBuidler(
      builder: (context, theme) => ImpaktfullUiAdaptiveScreen(
        title: widget.title,
        isDrawerEnabled: isSmall,
        drawer: isSmall ? drawer : null,
        builder: (context) => ImpaktfullUiAutoLayout.horizontal(
          children: [
            if (!isSmall) ...[
              drawer,
              ImpaktfullUiDivider(vertical: true),
            ],
            Expanded(
              child: Builder(
                builder: (context) {
                  if (selectedItem == null || selectedVariant == null) {
                    return const SizedBox.shrink();
                  }
                  return UiPlaygroundWidget(
                    key: ValueKey(selectedVariant),
                    item: selectedItem!,
                    variant: selectedVariant!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onVariantSelected(
    BuildContext context,
    UiPlaygroundSection section,
    UiPlaygroundItem item,
    UiPlaygroundVariant variant,
  ) {
    setState(() {
      selectedSection = section;
      selectedItem = item;
      selectedVariant = variant;
    });
  }
}
