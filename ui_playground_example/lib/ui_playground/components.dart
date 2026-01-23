import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';
import 'package:ui_playground_example/ui_playground/components.ui_playground.dart';

@UiPlaygroundComponents(
  components: [
    UiPlaygroundComponentConfig(
      ImpaktfullUiDivider,
      excludeParams: ['margin', 'theme'],
    ),
  ],
)
class AppComponents {
  static List<UiPlaygroundItem> get items =>
      GeneratedUiPlaygroundComponents.items;
}
