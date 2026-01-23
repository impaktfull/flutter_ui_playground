# ui_playground_example

Example Flutter application demonstrating the UI Playground system with code generation.

## Purpose

This app shows how to:
1. Annotate widgets with `@UiPlaygroundComponent`
2. Run the code generator to create playground items
3. Display components in the `UiPlayground` widget

## Getting Started

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Run Code Generation

```bash
dart run build_runner build
```

Or from the repository root:

```bash
./tools/build_runner_build.sh
```

### 3. Run the App

```bash
flutter run
```

## Project Structure

```
ui_playground_example/
├── lib/
│   ├── main.dart              # App entry point with UiPlayground widget
│   └── component/
│       ├── button.dart        # Annotated widget
│       └── button.g.dart      # Generated playground item
├── pubspec.yaml
└── README.md
```

## Example: Adding a New Component

### 1. Create Your Widget

```dart
// lib/component/my_card.dart
import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';

part 'my_card.g.dart';

@UiPlaygroundComponent(title: 'Card')
class MyCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color backgroundColor;

  const MyCard({
    required this.title,
    this.subtitle,
    this.backgroundColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (subtitle != null) Text(subtitle!),
          ],
        ),
      ),
    );
  }
}
```

### 2. Run the Generator

```bash
dart run build_runner build
```

### 3. Add to Playground

```dart
// lib/main.dart
import 'package:ui_playground/ui_playground.dart';
import 'component/button.dart';
import 'component/my_card.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UiPlayground(
      title: 'UI Playground Example',
      sections: [
        UiPlaygroundSection(
          title: 'Components',
          items: [
            ButtonPlaygroundItem(),
            MyCardPlaygroundItem(),  // Add your new component
          ],
        ),
      ],
    );
  }
}
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  ui_playground:
    path: ../ui_playground
  ui_playground_annotations:
    path: ../ui_playground_annotations

dev_dependencies:
  build_runner: ^2.4.9
  ui_playground_generator:
    path: ../ui_playground_generator
```
