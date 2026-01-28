import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';
import 'package:ui_playground_example/input/void_callback_input.dart';
import 'package:ui_playground_example/ui_playground/components.ui_playground.dart';

@UiPlaygroundComponents(
  extraComponents: [
    UiPlaygroundComponentConfig(
      ImpaktfullUiDivider,
    ),
    UiPlaygroundComponentConfig(
      ImpaktfullUiButton,
    ),
    UiPlaygroundComponentConfig(
      ImpaktfullUiListView,
      excludeParams: [
        'scrollPhysics',
        'controller',
        'localizations',
        'placeholderData',
      ],
    ),
  ],
  customInputs: [
    VoidCallbackInput,
  ],
)
class AppComponents {
  static List<UiPlaygroundItem> get items =>
      GeneratedUiPlaygroundComponents.items;
}
