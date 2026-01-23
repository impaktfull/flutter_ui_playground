import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/ui_playground_generator.dart';

/// Builder factory for the UI Playground aggregating generator.
///
/// This creates a LibraryBuilder that generates a complete standalone Dart file
/// with all imports and playground items.
Builder uiPlaygroundBuilder(BuilderOptions options) => LibraryBuilder(
  UiPlaygroundAggregatingGenerator(),
  generatedExtension: '.ui_playground.dart',
);
