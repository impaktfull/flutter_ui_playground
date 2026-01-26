/// Annotation to mark a widget for UI Playground code generation.
///
/// When a widget class is annotated with this, the ui_playground_generator
/// will generate the corresponding UiPlaygroundItem, UiPlaygroundVariant,
/// and UiPlaygroundInputs classes.
class UiPlaygroundComponent {
  /// The display title for this component in the playground.
  /// If not provided, the class name will be used.
  final String? title;

  /// List of constructor parameter names to exclude from input generation.
  /// Parameters like 'key' are automatically excluded.
  final List<String> excludeParams;

  const UiPlaygroundComponent({this.title, this.excludeParams = const []});
}
