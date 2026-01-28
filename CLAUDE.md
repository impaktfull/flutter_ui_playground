# UI Playground

Flutter monorepo for building interactive UI component playgrounds with code generation support.

## Project Structure

| Package                      | Type        | Purpose                                                            |
| ---------------------------- | ----------- | ------------------------------------------------------------------ |
| `ui_playground/`             | Flutter     | Playground UI widget and input components                          |
| `ui_playground_annotations/` | Pure Dart   | `@UiPlaygroundComponent` and `@UiPlaygroundComponents` annotations |
| `ui_playground_generator/`   | Pure Dart   | build_runner code generator                                        |
| `ui_playground_example/`     | Flutter app | Example app demonstrating usage                                    |

**Dependencies flow**: `ui_playground` and `ui_playground_generator` both depend on `ui_playground_annotations`.

## Commands

All commands should be run from the repository root:

```bash
# Get dependencies for all packages
./tools/packages_get.sh

# Run code generation (in example app)
./tools/build_runner_build.sh

# Verify changes
./tools/format.sh     # Format code
./tools/analyze.sh    # Run analyzer
```

For individual packages, use `dart pub get` (pure Dart) or `flutter pub get` (Flutter).

## Code Generation Flow

1. User annotates widgets with `@UiPlaygroundComponent`
2. User creates aggregation class with `@UiPlaygroundComponents`
3. Generator produces `.ui_playground.dart` files with:
   - `UiPlaygroundItem` instances for each component
   - `UiPlaygroundInputs` classes for interactive parameter controls
   - `UiPlaygroundVariant` definitions

## Key Files

- Generator logic: `ui_playground_generator/lib/src/ui_playground_generator.dart`
- Annotations: `ui_playground_annotations/lib/src/component.dart`
- Input widgets: `ui_playground/lib/src/inputs/`
- Generated output example: `ui_playground_example/lib/ui_playground/components.ui_playground.dart`

## Testing Changes

After modifying the generator:

1. Run `./tools/build_runner_build.sh` to regenerate example output
2. Run `./tools/analyze.sh` to check for errors
3. Inspect the generated file in `ui_playground_example/lib/ui_playground/`

## Documentation

Each package has its own README. Update them when changing:

- Public API (class names, method signatures, annotations)
- Usage patterns or workflows
- Supported parameter types

Keep the root `README.md` and package READMEs consistent with each other.

## Changelog Guidelines

This is a **public library** published to pub.dev. Changelogs should only include changes that affect library users:

**Include:**

- New public classes, methods, or properties
- New annotation parameters
- New supported parameter types in the generator
- Breaking changes to public API
- Deprecated APIs

**Exclude:**

- Internal implementation details
- Code refactoring that doesn't change public API
- Formatting or code style fixes
- Internal error handling improvements
- File reorganization

Use categories: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed` (only for user-facing bugs).
