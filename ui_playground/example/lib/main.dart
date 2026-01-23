import 'package:flutter/material.dart';

import 'package:ui_playground/ui_playground.dart';
import 'package:ui_playground_example/variant/button_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UiPlayground(
      title: 'Ui Playground',
      sections: [
        UiPlaygroundSection(
          title: 'Components',
          items: [
            ButtonItem(),
          ],
        ),
      ],
    );
  }
}
