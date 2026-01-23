import 'package:flutter/widgets.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/playground_section.dart';
import 'package:ui_playground/src/screen/home_screen.dart';
import 'package:ui_playground/src/theme/theme.dart';

class UiPlaygroundApp extends StatelessWidget {
  final String title;
  final List<UiPlaygroundSection> sections;
  final UiPlaygroundTheme? theme;

  const UiPlaygroundApp({
    required this.title,
    required this.sections,
    this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final app = ImpaktfullUiApp.maybeOf(context);
    final impaktfullUiTheme =
        app?.impaktfullUiTheme ??
        theme?.impaktfullUiTheme ??
        ImpaktfullUiTheme.getDefault();
    UiPlaygroundTheme.configure(impaktfullUiTheme);
    return ImpaktfullUiApp(
      impaktfullUiTheme: impaktfullUiTheme,
      localizations: app?.localizations ?? const ImpaktfullUiLocalizations(),
      locale: app?.locale,
      materialDarkTheme: app?.materialDarkTheme,
      materialLightTheme: app?.materialLightTheme,
      overrideComponents: app?.overrideComponents ?? const [],
      snackyBuilder: app?.snackyBuilder,
      snackyController: app?.snackyController,
      snackyUseNavigationObserver: app?.snackyUseNavigationObserver ?? true,
      supportedLocales: app?.supportedLocales ?? const <Locale>[Locale('en')],
      title: title,
      localizationsDelegates: app?.localizationsDelegates,
      targetPlatform: app?.targetPlatform,
      home: HomeScreen(
        title: title,
        sections: sections,
      ),
    );
  }
}
