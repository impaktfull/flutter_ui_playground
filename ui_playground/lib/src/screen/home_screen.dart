import 'package:flutter/widgets.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiAdaptiveScreen(
      title: title,
      builder: (context) => Container(),
    );
  }
}
