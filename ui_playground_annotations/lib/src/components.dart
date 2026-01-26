/// Annotation to mark a class as the aggregation point for playground components.
///
/// The generator will automatically find all classes annotated with
/// @UiPlaygroundComponent and generate playground items for them.
///
/// You can also add external widgets (from packages you can't modify) using
/// the [extraComponents] parameter.
///
/// Example:
/// ```dart
/// @UiPlaygroundComponents(
///   extraComponents: [
///     UiPlaygroundComponentConfig(ExternalButton, title: 'External Button'),
///     UiPlaygroundComponentConfig(ExternalCard, excludeParams: ['onTap']),
///   ],
/// )
/// class AppComponents {
///   static List<UiPlaygroundItem> get items => GeneratedUiPlaygroundComponents.items;
/// }
/// ```
///
/// Example with global custom inputs:
/// ```dart
/// @UiPlaygroundComponents(
///   customInputs: [
///     MyEdgeInsetsInput,  // extends UiPlaygroundInputItem<EdgeInsets>
///     MyAlignmentInput,   // extends UiPlaygroundInputItem<Alignment>
///   ],
/// )
/// class AppComponents { ... }
/// ```
///
/// To only use explicit components and skip scanning for @UiPlaygroundComponent:
/// ```dart
/// @UiPlaygroundComponents(
///   extraComponentsOnly: true,
///   extraComponents: [
///     UiPlaygroundComponentConfig(ExternalButton),
///   ],
/// )
/// ```
class UiPlaygroundComponents {
  /// Optional list of external components to include in the playground.
  /// These are widgets from packages you cannot annotate directly.
  final List<UiPlaygroundComponentConfig> extraComponents;

  /// If true, only use the [extraComponents] list and skip scanning for
  /// @UiPlaygroundComponent annotations in the codebase.
  final bool extraComponentsOnly;

  /// Global custom input classes that apply to all components.
  ///
  /// Each class must extend `UiPlaygroundInputItem<T>`. The generator will
  /// automatically extract the type `T` from the generic parameter and use
  /// it to match parameters of that type.
  ///
  /// Example:
  /// ```dart
  /// class MyEdgeInsetsInput extends UiPlaygroundInputItem<EdgeInsets> { ... }
  ///
  /// @UiPlaygroundComponents(
  ///   customInputs: [MyEdgeInsetsInput],
  /// )
  /// ```
  ///
  /// This will use `MyEdgeInsetsInput` for all `EdgeInsets` parameters.
  ///
  /// Per-component `customInputs` (on `@UiPlaygroundComponent` or
  /// `UiPlaygroundComponentConfig`) take precedence over these global inputs.
  final List<Type> customInputs;

  const UiPlaygroundComponents({
    this.extraComponents = const [],
    this.extraComponentsOnly = false,
    this.customInputs = const [],
  });
}

/// Configuration for an external widget to include in the playground.
///
/// Use this when you want to add widgets from external packages that
/// you cannot annotate with @UiPlaygroundComponent.
///
/// Example with custom inputs:
/// ```dart
/// UiPlaygroundComponentConfig(
///   ExternalWidget,
///   title: 'External Widget',
///   customInputs: [
///     MyEdgeInsetsInput,  // extends UiPlaygroundInputItem<EdgeInsets>
///   ],
/// )
/// ```
class UiPlaygroundComponentConfig {
  /// The widget type to generate playground items for.
  final Type type;

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

  const UiPlaygroundComponentConfig(
    this.type, {
    this.title,
    this.excludeParams = const [],
    this.customInputs = const [],
  });
}
