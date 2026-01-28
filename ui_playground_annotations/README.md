# ui_playground_annotations

[![pub package](https://img.shields.io/pub/v/ui_playground_annotations.svg)](https://pub.dev/packages/ui_playground_annotations)

A pure Dart package containing annotations for the UI Playground code generation system.

## Purpose

This package is intentionally kept as a **pure Dart package** (no Flutter dependencies) so that it can be used by both:

- [![ui_playground](https://img.shields.io/pub/v/ui_playground.svg)](https://pub.dev/packages/ui_playground) - The Flutter UI package
- [![ui_playground_generator](https://img.shields.io/pub/v/ui_playground_generator.svg)](https://pub.dev/packages/ui_playground_generator) - The build_runner code generator

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

| Parameter       | Type           | Default    | Description                                             |
| --------------- | -------------- | ---------- | ------------------------------------------------------- |
| `title`         | `String?`      | Class name | Display title for the component in the playground       |
| `excludeParams` | `List<String>` | `[]`       | Constructor parameters to exclude from input generation |
| `customInputs`  | `List<Type>`   | `[]`       | Custom input classes for this component                 |

#### Custom Inputs

Use `customInputs` to provide custom input widgets for types that aren't supported by default:

```dart
@UiPlaygroundComponent(
  title: 'My Widget',
  customInputs: [
    MyEdgeInsetsInput,  // extends UiPlaygroundInputItem<EdgeInsets>
  ],
)
class MyWidget extends StatelessWidget {
  final EdgeInsets padding;  // Will use MyEdgeInsetsInput
  // ...
}
```

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

| Parameter             | Type                                | Default | Description                                                                             |
| --------------------- | ----------------------------------- | ------- | --------------------------------------------------------------------------------------- |
| `extraComponents`     | `List<UiPlaygroundComponentConfig>` | `[]`    | External components to include (for widgets you can't annotate)                         |
| `extraComponentsOnly` | `bool`                              | `false` | If true, skip scanning for `@UiPlaygroundComponent` and only use `extraComponents` list |
| `customInputs`        | `List<Type>`                        | `[]`    | Global custom input classes that apply to all components                                |

#### Global Custom Inputs

Use `customInputs` on `@UiPlaygroundComponents` to define custom inputs that apply globally to all components. The generator automatically extracts the target type from the generic parameter:

```dart
// Define your custom input class
class MyEdgeInsetsInput extends UiPlaygroundInputItem<EdgeInsets> {
  MyEdgeInsetsInput(super.label, {super.initialValue, super.extraInfo});

  @override
  Widget build(BuildContext context) {
    // Build your custom input widget
  }
}

// Register it globally
@UiPlaygroundComponents(
  customInputs: [
    MyEdgeInsetsInput,  // All EdgeInsets parameters will use this
  ],
)
class AppComponents {
  static List<UiPlaygroundItem> get items => GeneratedUiPlaygroundComponents.items;
}
```

Per-component `customInputs` (on `@UiPlaygroundComponent` or `UiPlaygroundComponentConfig`) take precedence over global custom inputs.

### UiPlaygroundComponentConfig

Configuration for external widgets (from packages you cannot modify).

```dart
@UiPlaygroundComponents(
  extraComponents: [
    UiPlaygroundComponentConfig(
      ExternalButton,
      title: 'External Button',      // Optional: Display name
      excludeParams: ['onTap'],      // Optional: Parameters to exclude
      customInputs: [                // Optional: Custom input classes
        MyEdgeInsetsInput,
      ],
    ),
  ],
)
class AppComponents { ... }
```

### Creating Custom Input Classes

Custom input classes must extend `UiPlaygroundInputItem<T>` where `T` is the type you want to handle:

```dart
class MyEdgeInsetsInput extends UiPlaygroundInputItem<EdgeInsets> {
  MyEdgeInsetsInput(
    super.label, {
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    // Build your custom input widget
    return MyEdgeInsetsEditor(
      value: value,
      onChanged: updateState,
    );
  }
}
```

The generator will:

1. Find the generic type `T` from `UiPlaygroundInputItem<T>`
2. Use your custom input for all parameters of type `T`

#### Using extraComponentsOnly

When your playground only uses external components:

```dart
@UiPlaygroundComponents(
  extraComponentsOnly: true,  // Skip scanning for @UiPlaygroundComponent
  extraComponents: [
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
│       ├── component.dart              # @UiPlaygroundComponent annotation
│       └── components.dart             # @UiPlaygroundComponents annotation
└── pubspec.yaml
```
