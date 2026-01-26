/// Annotation to mark a widget for UI Playground code generation.
///
/// When a widget class is annotated with this, the ui_playground_generator
/// will generate the corresponding UiPlaygroundItem, UiPlaygroundVariant,
/// and UiPlaygroundInputs classes.
///
/// Example with custom inputs:
/// ```dart
/// @UiPlaygroundComponent(
///   title: 'My Widget',
///   customInputs: [
///     MyEdgeInsetsInput,  // extends UiPlaygroundInputItem<EdgeInsets>
///   ],
/// )
/// class MyWidget extends StatelessWidget {
///   final EdgeInsets padding;  // Will use MyEdgeInsetsInput
///   // ...
/// }
/// ```
class UiPlaygroundComponent {
  /// The display title for this component in the playground.
  /// If not provided, the class name will be used.
  final String? title;

  /// List of constructor parameter names to exclude from input generation.
  /// Parameters like 'key' are automatically excluded.
  final List<String> excludeParams;

  /// Custom input classes for this component.
  ///
  /// Each class must extend `UiPlaygroundInputItem<T>`. The generator will
  /// automatically extract the type `T` from the generic parameter and use
  /// it to match parameters of that type.
  ///
  /// These take precedence over global `customInputs` defined on
  /// `@UiPlaygroundComponents`.
  final List<Type> customInputs;

  const UiPlaygroundComponent({
    this.title,
    this.excludeParams = const [],
    this.customInputs = const [],
  });
}
