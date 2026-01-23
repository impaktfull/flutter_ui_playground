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

/// Configuration for an external widget to include in the playground.
///
/// Use this when you want to add widgets from external packages that
/// you cannot annotate with @UiPlaygroundComponent.
class UiPlaygroundComponentConfig {
  /// The widget type to generate playground items for.
  final Type type;

  /// The display title for this component in the playground.
  /// If not provided, the class name will be used.
  final String? title;

  /// List of constructor parameter names to exclude from input generation.
  /// Parameters like 'key' are automatically excluded.
  final List<String> excludeParams;

  const UiPlaygroundComponentConfig(
    this.type, {
    this.title,
    this.excludeParams = const [],
  });
}

/// Annotation to mark a class as the aggregation point for playground components.
///
/// The generator will automatically find all classes annotated with
/// @UiPlaygroundComponent and generate playground items for them.
///
/// You can also add external widgets (from packages you can't modify) using
/// the [components] parameter.
///
/// Example:
/// ```dart
/// @UiPlaygroundComponents(
///   components: [
///     UiPlaygroundComponentConfig(ExternalButton, title: 'External Button'),
///     UiPlaygroundComponentConfig(ExternalCard, excludeParams: ['onTap']),
///   ],
/// )
/// class AppComponents {
///   static List<UiPlaygroundItem> get items => GeneratedUiPlaygroundComponents.items;
/// }
/// ```
///
/// To only use explicit components and skip scanning for @UiPlaygroundComponent:
/// ```dart
/// @UiPlaygroundComponents(
///   componentsOnly: true,
///   components: [
///     UiPlaygroundComponentConfig(ExternalButton),
///   ],
/// )
/// ```
class UiPlaygroundComponents {
  /// Optional list of external components to include in the playground.
  /// These are widgets from packages you cannot annotate directly.
  final List<UiPlaygroundComponentConfig> components;

  /// If true, only use the [components] list and skip scanning for
  /// @UiPlaygroundComponent annotations in the codebase.
  final bool componentsOnly;

  const UiPlaygroundComponents({
    this.components = const [],
    this.componentsOnly = false,
  });
}
