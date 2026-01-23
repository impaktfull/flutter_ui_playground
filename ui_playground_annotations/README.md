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

Marks a class as the aggregation point for all generated playground items.

```dart
import 'package:ui_playground/ui_playground.dart';
import 'package:my_app/ui_playground/components.ui_playground.dart';

@UiPlaygroundComponents()
class AppComponents {
  static List<UiPlaygroundItem> get items => GeneratedUiPlaygroundComponents.items;
}
```

The generator will:
1. Scan all files for `@UiPlaygroundComponent` annotations
2. Generate a complete standalone file with all imports and playground items
3. Create `GeneratedUiPlaygroundComponents.items` containing all components

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `components` | `List<UiPlaygroundComponentConfig>` | `[]` | External components to include (for widgets you can't annotate) |
| `componentsOnly` | `bool` | `false` | If true, skip scanning for `@UiPlaygroundComponent` and only use `components` list |

### UiPlaygroundComponentConfig

Configuration for external widgets (from packages you cannot modify).

```dart
@UiPlaygroundComponents(
  components: [
    UiPlaygroundComponentConfig(
      ExternalButton,
      title: 'External Button',      // Optional: Display name
      excludeParams: ['onTap'],      // Optional: Parameters to exclude
    ),
  ],
)
class AppComponents { ... }
```

#### Using componentsOnly

When your playground only uses external components:

```dart
@UiPlaygroundComponents(
  componentsOnly: true,  // Skip scanning for @UiPlaygroundComponent
  components: [
    UiPlaygroundComponentConfig(ExternalButton),
    UiPlaygroundComponentConfig(ExternalCard),
  ],
)
class AppComponents {
  static List<UiPlaygroundItem> get items => GeneratedUiPlaygroundComponents.items;
}
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
