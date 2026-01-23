import 'package:ui_playground/src/model/item/playground_variant.dart';

abstract class UiPlaygroundItem {
  String get title;

  const UiPlaygroundItem();

  String get slug => title
      .replaceAllMapped(
        RegExp(r'(?<=[a-z])[A-Z]'),
        (Match m) => '-${m.group(0)!.toLowerCase()}',
      )
      .toLowerCase();

  List<UiPlaygroundVariant> get variants;
}
