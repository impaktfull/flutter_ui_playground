# ui_playground_generator

A build_runner code generator that creates UI Playground items from annotated widget classes.

## Purpose

This package automatically generates `UiPlaygroundItem`, `UiPlaygroundVariant`, and `UiPlaygroundInputs` classes for widgets annotated with `@UiPlaygroundComponent`. All generated code is aggregated into a **single file** marked with `@UiPlaygroundComponents`.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  ui_playground:
    path: ../ui_playground
  ui_playground_annotations:
    path: ../ui_playground_annotations

dev_dependencies:
  build_runner: ^2.4.9
  ui_playground_generator:
    path: ../ui_playground_generator
```

## Usage

### 1. Create a Trigger File

Create a simple file that triggers the generation:

```dart
// lib/ui_playground_items.dart
@UiPlaygroundComponents()
library;

import 'package:ui_playground/ui_playground.dart';
```

That's it! No `part` directives, no manual imports needed.

### 2. Annotate Your Widgets

```dart
// lib/component/button.dart
import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';

@UiPlaygroundComponent(
  title: 'My Button',
  excludeParams: ['onTap'],
)
class MyButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final VoidCallback? onTap;

  const MyButton({
    required this.title,
    this.isEnabled = true,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onTap : null,
      child: Text(title),
    );
  }
}
```

### 3. Run the Generator

```bash
dart run build_runner build
```

Or use watch mode:

```bash
dart run build_runner watch
```

### 4. Use the Generated File

The generator creates a complete standalone file `ui_playground_items.ui_playground.dart` with all imports included:

```dart
import 'package:my_app/ui_playground_items.ui_playground.dart';

UiPlaygroundApp(
  sections: [
    UiPlaygroundSection(
      title: 'Buttons',
      items: [
        MyButtonPlaygroundItem(),
      ],
    ),
  ],
)
```

## Generated Code

The generator creates three classes for each annotated widget:

```dart
// ui_playground_items.g.dart (all in one file)

class MyButtonPlaygroundItem extends UiPlaygroundItem { ... }
class MyButtonPlaygroundVariant extends UiPlaygroundVariant<MyButtonPlaygroundInputs> { ... }
class MyButtonPlaygroundInputs extends UiPlaygroundInputs { ... }
```

## Supported Parameter Types

The generator automatically maps Dart types to playground inputs:

| Dart Type | Generated Input |
|-----------|-----------------|
| `String` | `UiPlaygroundStringInput` |
| `bool` | `UiPlaygroundBooleanInput` |
| `int` | `UiPlaygroundIntInput` |
| `double` | `UiPlaygroundDoubleInput` |
| `Enum` | `UiPlaygroundEnumInput<T>` |
| `Color` | `UiPlaygroundColorInput` |
| `DateTime` | `UiPlaygroundDateTimeInput` |

### Automatically Excluded Parameters

- `key` (Widget key)
- Function types (callbacks like `VoidCallback`, `Function`)

### Manually Excluding Parameters

```dart
@UiPlaygroundComponent(
  excludeParams: ['onTap', 'controller', 'focusNode'],
)
class MyWidget extends StatelessWidget { ... }
```

## Package Structure

```
ui_playground_generator/
├── lib/
│   ├── builder.dart                    # Builder factory
│   ├── ui_playground_generator.dart    # Library exports
│   └── src/
│       ├── ui_playground_generator.dart  # Aggregating generator
│       └── parameter_analyzer.dart       # Parameter type analysis
├── build.yaml                          # Build configuration
└── pubspec.yaml
```

## Why a Separate Annotations Package?

The generator depends on `ui_playground_annotations` (pure Dart) instead of `ui_playground` (Flutter) because build_runner runs in a pure Dart environment and cannot resolve Flutter dependencies.
