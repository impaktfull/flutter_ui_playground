import 'package:flutter/material.dart';

import 'package:ui_playground/ui_playground.dart';
import 'package:ui_playground_example/ui_playground/components.dart';

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
          items: AppComponents.items,
        ),
      ],
    );
  }
}
