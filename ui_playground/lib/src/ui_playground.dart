import 'package:flutter/widgets.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/playground_section.dart';
import 'package:ui_playground/src/screen/home_screen.dart';

class UiPlayground extends StatelessWidget {
  final String title;
  final List<UiPlaygroundSection> sections;

  const UiPlayground({
    required this.title,
    required this.sections,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiApp(
      title: title,
      home: HomeScreen(
        title: title,
        sections: sections,
      ),
    );
  }
}
