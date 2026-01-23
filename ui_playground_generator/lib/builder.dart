import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/ui_playground_generator.dart';

/// Builder factory for the UI Playground generator.
///
/// This creates a SharedPartBuilder that generates code for all classes
/// annotated with @UiPlaygroundComponent.
Builder uiPlaygroundBuilder(BuilderOptions options) => SharedPartBuilder(
  [UiPlaygroundComponentGenerator()],
  'ui_playground',
);
