# ui_playground_annotations

A pure Dart package containing annotations for the UI Playground code generation system.

## Purpose

This package is intentionally kept as a **pure Dart package** (no Flutter dependencies) so that it can be used by both:
- `ui_playground` - The Flutter UI package
- `ui_playground_generator` - The build_runner code generator

This separation is necessary because build_runner runs in a pure Dart environment and cannot depend on Flutter packages.

## Available Annotations

### @UiPlaygroundComponent

Marks a widget class for playground code generation.

```dart
import 'package:ui_playground/ui_playground.dart';

@UiPlaygroundComponent(
  title: 'My Button',           // Optional: Display name in playground
  excludeParams: ['onTap'],     // Optional: Parameters to exclude from inputs
)
class MyButton extends StatelessWidget {
  // ...
}
```

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String?` | Class name | Display title for the component in the playground |
| `excludeParams` | `List<String>` | `[]` | Constructor parameters to exclude from input generation |

### @UiPlaygroundComponents

Marks a library file as the aggregation point for all generated playground items.

```dart
// lib/ui_playground_items.dart
@UiPlaygroundComponents()
library;

import 'package:ui_playground/ui_playground.dart';
```

That's it! The generator will:
1. Scan all files for `@UiPlaygroundComponent` annotations
2. Generate a complete standalone file `ui_playground_items.ui_playground.dart` with all imports and playground items

You then import the generated file:
```dart
import 'package:my_app/ui_playground_items.ui_playground.dart';
```

## Usage

This package is typically not used directly. Instead, use `ui_playground` which re-exports these annotations:

```dart
// Recommended: Import from ui_playground
import 'package:ui_playground/ui_playground.dart';

// Also works: Import directly
import 'package:ui_playground_annotations/ui_playground_annotations.dart';
```

## Package Structure

```
ui_playground_annotations/
├── lib/
│   ├── ui_playground_annotations.dart  # Library export
│   └── src/
│       └── component.dart              # Annotations
└── pubspec.yaml
```
