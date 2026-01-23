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
    final optionalTheme = ImpaktfullUiTheme.maybeOf(context);
    final impaktfullUiTheme =
        optionalTheme ??
        theme?.impaktfullUiTheme ??
        ImpaktfullUiTheme.getDefault();
    UiPlaygroundTheme.configure(impaktfullUiTheme);
    return ImpaktfullUiApp(
      title: title,
      impaktfullUiTheme: impaktfullUiTheme,
      home: HomeScreen(
        title: title,
        sections: sections,
      ),
    );
  }
}
