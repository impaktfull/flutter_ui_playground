# UI Playground

A Flutter UI component playground system with code generation support. This monorepo contains multiple packages that work together to create an interactive playground for testing and showcasing UI components.

## Packages

| Package | Description |
|---------|-------------|
| [ui_playground](./ui_playground/) | Flutter package providing the playground UI widget |
| [ui_playground_annotations](./ui_playground_annotations/) | Pure Dart package with annotations for code generation |
| [ui_playground_generator](./ui_playground_generator/) | Code generator that creates playground items from annotations |
| [ui_playground_example](./ui_playground_example/) | Example app demonstrating the playground system |

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     ui_playground_example                        │
│  (Flutter app that uses the playground and generator)           │
└─────────────────────────────────────────────────────────────────┘
        │                      │                      │
        ▼                      ▼                      ▼
┌───────────────┐    ┌─────────────────┐    ┌─────────────────────┐
│ ui_playground │    │ ui_playground_  │    │ ui_playground_      │
│   (Flutter)   │    │  annotations    │    │    generator        │
│               │    │   (Dart only)   │    │   (Dart only)       │
└───────────────┘    └─────────────────┘    └─────────────────────┘
        │                      ▲                      │
        │                      │                      │
        └──────────────────────┴──────────────────────┘
                    (both depend on annotations)
```

## Quick Start

1. Add dependencies to your `pubspec.yaml`:

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

2. Create a simple trigger file:

```dart
// lib/ui_playground_items.dart
@UiPlaygroundComponents()
library;

import 'package:ui_playground/ui_playground.dart';
```

3. Annotate your widgets:

```dart
// lib/component/my_button.dart
import 'package:ui_playground/ui_playground.dart';

@UiPlaygroundComponent(title: 'My Button')
class MyButton extends StatelessWidget {
  final String title;
  final bool isEnabled;

  const MyButton({required this.title, this.isEnabled = true, super.key});

  @override
  Widget build(BuildContext context) { ... }
}
```

4. Run the generator:

```bash
dart run build_runner build
```

5. Import and use the generated file:

```dart
import 'ui_playground_items.ui_playground.dart';

UiPlaygroundApp(
  title: 'My App Playground',
  sections: [
    UiPlaygroundSection(
      title: 'Buttons',
      items: [
        MyButtonPlaygroundItem(),  // Generated automatically
      ],
    ),
  ],
)
```

The generator automatically finds all `@UiPlaygroundComponent` widgets, generates all imports, and creates a complete standalone file.

## Development

```bash
# Get all dependencies
./tools/packages_get.sh

# Run code generation
./tools/build_runner_build.sh

# Format code
./tools/format.sh

# Analyze code
./tools/analyze.sh
```
