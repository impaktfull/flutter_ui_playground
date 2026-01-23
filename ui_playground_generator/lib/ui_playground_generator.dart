/// UI Playground Generator
///
/// A code generator that creates UiPlaygroundItem classes for widgets
/// annotated with @UiPlaygroundComponent.
///
/// ## Usage
///
/// 1. Add the annotation to your widget:
/// ```dart
/// @UiPlaygroundComponent(title: 'My Button')
/// class MyButton extends StatelessWidget {
///   final String title;
///   final bool isEnabled;
///   // ...
/// }
/// ```
///
/// 2. Run the generator:
/// ```bash
/// dart run build_runner build
/// ```
///
/// 3. Generated code will be in `*.g.dart` files.
library;

export 'src/ui_playground_generator.dart' show UiPlaygroundComponentGenerator;
export 'src/parameter_analyzer.dart'
    show ParameterAnalyzer, AnalyzedParameter, InputType;
