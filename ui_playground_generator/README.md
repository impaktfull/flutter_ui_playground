# ui_playground_generator

A build_runner code generator that creates UI Playground items from annotated widget classes.

## Purpose

This package automatically generates `UiPlaygroundItem`, `UiPlaygroundVariant`, and `UiPlaygroundInputs` classes for widgets annotated with `@UiPlaygroundComponent`. This eliminates the boilerplate of manually creating playground items.

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

### 1. Annotate Your Widget

```dart
import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';

part 'my_button.g.dart';  // Required: Include the generated part file

@UiPlaygroundComponent(
  title: 'My Button',
  excludeParams: ['onTap'],  // Exclude callback parameters
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

### 2. Run the Generator

```bash
dart run build_runner build
```

Or use watch mode for continuous generation:

```bash
dart run build_runner watch
```

### 3. Use the Generated Item

The generator creates a file `my_button.g.dart` containing:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_button.dart';

class MyButtonPlaygroundItem extends UiPlaygroundItem {
  @override
  String get title => 'My Button';

  @override
  List<UiPlaygroundVariant> get variants => [MyButtonPlaygroundVariant()];
}

class MyButtonPlaygroundVariant extends UiPlaygroundVariant<MyButtonPlaygroundInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(BuildContext context, MyButtonPlaygroundInputs inputs) {
    return MyButton(
      title: inputs.title.value ?? '',
      isEnabled: inputs.isEnabled.value ?? true,
    );
  }

  @override
  MyButtonPlaygroundInputs inputs() => MyButtonPlaygroundInputs();
}

class MyButtonPlaygroundInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title', initialValue: '{title}');
  final isEnabled = UiPlaygroundBooleanInput('Is Enabled', initialValue: true);

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [title, isEnabled];
}
```

## Supported Parameter Types

The generator automatically maps Dart types to playground inputs:

| Dart Type | Generated Input | Notes |
|-----------|-----------------|-------|
| `String` | `UiPlaygroundStringInput` | |
| `bool` | `UiPlaygroundBooleanInput` | |
| `int` | `UiPlaygroundIntInput` | |
| `double` | `UiPlaygroundDoubleInput` | |
| `Enum` | `UiPlaygroundEnumInput<T>` | Auto-detects enum types |
| `Color` | `UiPlaygroundColorInput` | |
| `DateTime` | `UiPlaygroundDateTimeInput` | |

### Automatically Excluded Parameters

The following parameters are automatically excluded:
- `key` (Widget key)
- Function types (callbacks like `VoidCallback`, `Function`)

### Manually Excluding Parameters

Use `excludeParams` to exclude additional parameters:

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
│   ├── builder.dart                    # Builder factory for build_runner
│   ├── ui_playground_generator.dart    # Library exports
│   └── src/
│       ├── ui_playground_generator.dart  # Main generator logic
│       └── parameter_analyzer.dart       # Parameter type analysis
├── build.yaml                          # Build configuration
└── pubspec.yaml
```

## Why a Separate Annotations Package?

The generator depends on `ui_playground_annotations` (pure Dart) instead of `ui_playground` (Flutter) because:

1. **build_runner runs in pure Dart** - It cannot resolve Flutter dependencies
2. **Compilation would fail** - Types like `Color`, `Widget`, `VoidCallback` are not available in the Dart VM
3. **Separation of concerns** - Annotations are metadata and don't need Flutter runtime
