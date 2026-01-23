# ui_playground_example

Example Flutter application demonstrating the UI Playground system with code generation.

## Purpose

This app shows how to:
1. Annotate widgets with `@UiPlaygroundComponent`
2. Create an aggregation class with `@UiPlaygroundComponents`
3. Add external components with `UiPlaygroundComponentConfig`
4. Run the code generator to create playground items
5. Display components in the `UiPlayground` widget

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
│   ├── main.dart                                  # App entry point
│   ├── ui_playground/
│   │   ├── components.dart                        # Aggregation class with @UiPlaygroundComponents
│   │   └── components.ui_playground.dart          # Generated file
│   └── component/
│       └── button.dart                            # Annotated widget
├── pubspec.yaml
└── README.md
```

## Example: Adding Your Own Widget

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

The generator automatically finds all `@UiPlaygroundComponent` annotated widgets.

## Example: Adding External Components

For widgets from external packages you cannot annotate:

```dart
// lib/ui_playground/components.dart
import 'package:external_ui/external_ui.dart';
import 'package:ui_playground/ui_playground.dart';
import 'package:my_app/ui_playground/components.ui_playground.dart';

@UiPlaygroundComponents(
  components: [
    UiPlaygroundComponentConfig(
      ExternalButton,
      title: 'External Button',
      excludeParams: ['onTap'],
    ),
  ],
)
class AppComponents {
  static List<UiPlaygroundItem> get items => GeneratedUiPlaygroundComponents.items;
}
```

### componentsOnly Mode

To only use external components and skip scanning:

```dart
@UiPlaygroundComponents(
  componentsOnly: true,
  components: [
    UiPlaygroundComponentConfig(ExternalButton),
    UiPlaygroundComponentConfig(ExternalCard),
  ],
)
class AppComponents {
  static List<UiPlaygroundItem> get items => GeneratedUiPlaygroundComponents.items;
}
```

## Usage in App

```dart
// lib/main.dart
import 'package:ui_playground/ui_playground.dart';
import 'ui_playground/components.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UiPlaygroundApp(
      title: 'UI Playground Example',
      sections: [
        UiPlaygroundSection(
          title: 'Components',
          items: AppComponents.items,
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
  ui_playground: ^0.0.1
  ui_playground_annotations: ^0.0.1

dev_dependencies:
  build_runner: ^2.4.9
  ui_playground_generator: ^0.0.1
```
