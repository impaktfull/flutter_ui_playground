import 'dart:ui';

class UiPlaygroundTheme {
  final Color primaryColor;
  final Color accentColor;
  final Color secondaryColor;
  final Color? canvasColor;
  final Color? cardColor;
  final Color? textColor;
  final Color? textSecondaryColor;
  final Color? textTertiaryColor;

  const UiPlaygroundTheme({
    required this.primaryColor,
    required this.accentColor,
    required this.secondaryColor,
    this.canvasColor,
    this.cardColor,
    this.textColor,
    this.textSecondaryColor,
    this.textTertiaryColor,
  });
}
