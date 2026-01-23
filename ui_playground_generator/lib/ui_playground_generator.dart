/// UI Playground Generator
///
/// A code generator that creates UiPlaygroundItem classes for widgets
/// annotated with @UiPlaygroundComponent.
///
/// ## Usage
///
/// 1. Create an aggregation file with @UiPlaygroundComponents:
/// ```dart
/// @UiPlaygroundComponents()
/// library;
///
/// part 'ui_playground_items.g.dart';
/// ```
///
/// 2. Add @UiPlaygroundComponent to your widgets:
/// ```dart
/// @UiPlaygroundComponent(title: 'My Button')
/// class MyButton extends StatelessWidget {
///   final String title;
///   final bool isEnabled;
///   // ...
/// }
/// ```
///
/// 3. Run the generator:
/// ```bash
/// dart run build_runner build
/// ```
///
/// 4. All generated code will be in the single `.g.dart` file.
library;

export 'src/ui_playground_generator.dart' show UiPlaygroundAggregatingGenerator;
export 'src/parameter_analyzer.dart'
    show ParameterAnalyzer, AnalyzedParameter, InputType;
