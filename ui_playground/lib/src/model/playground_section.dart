import 'package:ui_playground/src/model/item/playground_item.dart';

class UiPlaygroundSection {
  final String title;
  final List<UiPlaygroundItem> items;

  UiPlaygroundSection({
    required this.title,
    required this.items,
  });
}
