import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';

extension UiPlaygroundThemeExtension on UiPlaygroundTheme {
  ImpaktfullUiTheme? get impaktfullUiTheme => ImpaktfullUiTheme.custom(
    primary: primaryColor,
    accent: accentColor,
    secondary: secondaryColor,
    canvas: canvasColor,
    card: cardColor,
    text: textColor,
    textSecondary: textSecondaryColor,
    textTertiary: textTertiaryColor,
  );
}
