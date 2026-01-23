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

2. Annotate your widget:

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

3. Run the generator:

```bash
dart run build_runner build
```

4. Use the generated playground item in your app:

```dart
UiPlayground(
  title: 'My App Playground',
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
