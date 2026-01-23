import 'package:flutter/widgets.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/screen/home_screen.dart';

class UiPlayground extends StatelessWidget {
  final String title;

  const UiPlayground({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiApp(
      title: title,
      home: HomeScreen(
        title: title,
      ),
    );
  }
}
