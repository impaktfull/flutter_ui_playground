import 'package:ui_playground_generator/ui_playground_generator.dart';

extension InputTypeExtensions on Map<InputType, String> {
  String? getInputTypeClass(InputType inputType) {
    InputType? internalInputType;
    for (final element in keys) {
      if (element.name == inputType.name) {
        internalInputType = element;
        break;
      }
    }
    return this[internalInputType];
  }
}
