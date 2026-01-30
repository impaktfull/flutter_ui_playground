import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

class UiPlaygroundTheme {
  final Color _primary;
  final Color _accent;
  final Color _secondary;
  final Color? _canvas;
  final Color? _card;
  final Color? _text;
  final Color? _textSecondary;
  final Color? _textTertiary;

  static ImpaktfullUiTheme<Object>? _impaktfullUiTheme;

  static Color get primaryColor => _impaktfullUiTheme!.colors.primary;

  static Color get accentColor => _impaktfullUiTheme!.colors.accent;

  static Color get secondaryColor => _impaktfullUiTheme!.colors.secondary;

  static TextStyle get textOnAccentColor => _impaktfullUiTheme!.textStyles.onAccent.text.medium;
  static TextStyle get textOnSecondaryColor => _impaktfullUiTheme!.textStyles.onSecondary.text.medium;

  const UiPlaygroundTheme({
    required Color primaryColor,
    required Color accentColor,
    required Color secondaryColor,
    Color? canvasColor,
    Color? cardColor,
    Color? textColor,
    Color? textSecondaryColor,
    Color? textTertiaryColor,
  }) : _textTertiary = textTertiaryColor,
       _textSecondary = textSecondaryColor,
       _text = textColor,
       _card = cardColor,
       _canvas = canvasColor,
       _secondary = secondaryColor,
       _accent = accentColor,
       _primary = primaryColor;

  static void configure(ImpaktfullUiTheme<Object> impaktfullUiTheme) {
    _impaktfullUiTheme = impaktfullUiTheme;
  }
}

extension UiPlaygroundThemeExtension on UiPlaygroundTheme {
  ImpaktfullUiTheme? get impaktfullUiTheme => ImpaktfullUiTheme.custom(
    primary: _primary,
    accent: _accent,
    secondary: _secondary,
    canvas: _canvas,
    card: _card,
    text: _text,
    textSecondary: _textSecondary,
    textTertiary: _textTertiary,
  );
}
