# ui_playground

[![pub package](https://img.shields.io/pub/v/ui_playground.svg)](https://pub.dev/packages/ui_playground)

## Purpose

A Flutter package that provides an interactive playground for testing and showcasing UI components. It allows you to explore different widget variants and modify their properties in real-time.

## Features

- Interactive playground UI for testing components
- Support for multiple component sections
- Real-time input controls for widget properties
- Support for various input types (String, bool, int, double, enum, Color, DateTime)
- Re-exports annotations from `ui_playground_annotations`

## Other packages

This packages is part of an ecosystem of packages that work together to create an ui playground for testing and showcasing UI components.

- `ui_playground_annotations` [![ui_playground_annotations](https://img.shields.io/pub/v/ui_playground_annotations.svg)](https://pub.dev/packages/ui_playground_annotations) - The annotations package for the ui_playground_generator
- `ui_playground_generator` [![ui_playground_generator](https://img.shields.io/pub/v/ui_playground_generator.svg)](https://pub.dev/packages/ui_playground_generator) - The build_runner code generator that creates playground items from annotations

## Installation

```yaml
dependencies:
  ui_playground:
    path: ../ui_playground
```

## Usage

### Basic Setup

```dart
import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UiPlaygroundApp(
      title: 'My Component Library',
      sections: [
        UiPlaygroundSection(
          title: 'Buttons',
          items: [
            ButtonPlaygroundItem(),
          ],
        ),
        UiPlaygroundSection(
          title: 'Inputs',
          items: [
            TextFieldPlaygroundItem(),
          ],
        ),
      ],
    );
  }
}
```

### Creating Playground Items Manually

You can create playground items manually by extending the base classes:

```dart
class MyButtonItem extends UiPlaygroundItem {
  @override
  String get title => 'My Button';

  @override
  List<UiPlaygroundVariant> get variants => [
    MyButtonVariant(),
  ];
}

class MyButtonVariant extends UiPlaygroundVariant<MyButtonInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(BuildContext context, MyButtonInputs inputs) {
    return MyButton(
      title: inputs.title.value ?? '',
      isEnabled: inputs.isEnabled.value ?? true,
    );
  }

  @override
  MyButtonInputs inputs() => MyButtonInputs();
}

class MyButtonInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title', initialValue: 'Click me');
  final isEnabled = UiPlaygroundBooleanInput('Enabled', initialValue: true);

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [title, isEnabled];
}
```

### Using Code Generation (Recommended)

For easier setup, use the `@UiPlaygroundComponent` annotation with the generator:

```dart
import 'package:ui_playground/ui_playground.dart';

part 'my_button.g.dart';

@UiPlaygroundComponent(title: 'My Button')
class MyButton extends StatelessWidget {
  final String title;
  final bool isEnabled;

  const MyButton({required this.title, this.isEnabled = true, super.key});

  @override
  Widget build(BuildContext context) { ... }
}
```

See [![ui_playground_generator](https://img.shields.io/pub/v/ui_playground_generator.svg)](https://pub.dev/packages/ui_playground_generator) for more details on code generation.

## Available Input Types

| Input Type | Class                       | Dart Type  |
| ---------- | --------------------------- | ---------- |
| String     | `UiPlaygroundStringInput`   | `String`   |
| Boolean    | `UiPlaygroundBooleanInput`  | `bool`     |
| Integer    | `UiPlaygroundIntInput`      | `int`      |
| Double     | `UiPlaygroundDoubleInput`   | `double`   |
| Enum       | `UiPlaygroundEnumInput<T>`  | `Enum`     |
| Color      | `UiPlaygroundColorInput`    | `Color`    |
| DateTime   | `UiPlaygroundDateTimeInput` | `DateTime` |
| Icon       | `UiPlaygroundIconInput`     | `IconData` |

## Package Structure

```
ui_playground/
├── lib/
│   ├── ui_playground.dart           # Main library export
│   └── src/
│       ├── annotations/             # Re-exported from ui_playground_annotations
│       ├── inputs/                  # Input widgets for different types
│       ├── model/                   # Core models (Item, Variant, Inputs)
│       ├── screen/                  # Playground screens
│       ├── theme/                   # Theming support
│       └── widget/                  # UI widgets
└── pubspec.yaml
```
