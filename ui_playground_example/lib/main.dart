import 'package:flutter/material.dart';

import 'package:ui_playground/ui_playground.dart';
import 'package:ui_playground_example/component/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UiPlaygroundApp(
      title: 'Ui Playground',
      sections: [
        UiPlaygroundSection(
          title: 'Components',
          items: [
            ButtonPlaygroundItem(),
          ],
        ),
      ],
    );
  }
}
