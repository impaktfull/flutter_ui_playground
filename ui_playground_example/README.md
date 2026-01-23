# ui_playground_example

Example Flutter application demonstrating the UI Playground system with code generation.

## Purpose

This app shows how to:
1. Annotate widgets with `@UiPlaygroundComponent`
2. Create an aggregation file with `@UiPlaygroundComponents`
3. Run the code generator to create playground items in a single file
4. Display components in the `UiPlayground` widget

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
│   ├── main.dart                              # App entry point
│   ├── ui_playground_items.dart               # Trigger file with @UiPlaygroundComponents
│   ├── ui_playground_items.ui_playground.dart # Generated file (complete standalone library)
│   └── component/
│       └── button.dart                        # Annotated widget
├── pubspec.yaml
└── README.md
```

## Example: Adding a New Component

### 1. Create Your Widget

```dart
// lib/component/my_card.dart
import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';

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

That's it! The generator automatically:
- Finds all `@UiPlaygroundComponent` annotated widgets
- Generates imports for each component
- Creates all playground items in a single file

### 3. Use in Playground

```dart
// lib/main.dart
import 'package:ui_playground/ui_playground.dart';
import 'ui_playground_items.ui_playground.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UiPlaygroundApp(
      title: 'UI Playground Example',
      sections: [
        UiPlaygroundSection(
          title: 'Components',
          items: [
            ButtonPlaygroundItem(),
            MyCardPlaygroundItem(),  // Generated automatically
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
