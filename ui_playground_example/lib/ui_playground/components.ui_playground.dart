// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// UiPlaygroundAggregatingGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';
import 'package:ui_playground_example/component/button.dart';
import 'package:ui_playground_example/component/input_tester.dart';

// **************************************************************************
// GeneratedUiPlaygroundComponents
// **************************************************************************

class GeneratedUiPlaygroundComponents {
  GeneratedUiPlaygroundComponents._();

  static List<UiPlaygroundItem> get items => [
    ButtonPlaygroundItem(),
    InputTesterPlaygroundItem(),
  ];
}

// **************************************************************************
// Button
// **************************************************************************

class ButtonPlaygroundItem extends UiPlaygroundItem {
  @override
  String get title => 'Button';

  @override
  List<UiPlaygroundVariant> get variants => [ButtonPlaygroundVariant()];
}

class ButtonPlaygroundVariant
    extends UiPlaygroundVariant<ButtonPlaygroundInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(BuildContext context, ButtonPlaygroundInputs inputs) {
    return Button(title: inputs.title.value ?? '{title}');
  }

  @override
  ButtonPlaygroundInputs inputs() => ButtonPlaygroundInputs();
}

class ButtonPlaygroundInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title', initialValue: '{title}');

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [title];
}

// **************************************************************************
// InputTester
// **************************************************************************

class InputTesterPlaygroundItem extends UiPlaygroundItem {
  @override
  String get title => 'Input Tester';

  @override
  List<UiPlaygroundVariant> get variants => [InputTesterPlaygroundVariant()];
}

class InputTesterPlaygroundVariant
    extends UiPlaygroundVariant<InputTesterPlaygroundInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(BuildContext context, InputTesterPlaygroundInputs inputs) {
    return InputTester(
      title: inputs.title.value ?? '{title}',
      inputTesterType:
          inputs.inputTesterType.value ?? InputTesterType.values.first,
      isEnabled: inputs.isEnabled.value ?? false,
      count: inputs.count.value ?? 0,
      value: inputs.value.value ?? 0.0,
      color: inputs.color.value ?? UiPlaygroundTheme.accentColor,
      dateTime: inputs.dateTime.value ?? DateTime.now(),
    );
  }

  @override
  InputTesterPlaygroundInputs inputs() => InputTesterPlaygroundInputs();
}

class InputTesterPlaygroundInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title', initialValue: '{title}');
  final inputTesterType = UiPlaygroundEnumInput<InputTesterType>(
    'Input Tester Type',
    initialValue: InputTesterType.values.first,
    options: InputTesterType.values,
  );
  final isEnabled = UiPlaygroundBooleanInput('Is Enabled', initialValue: false);
  final count = UiPlaygroundIntInput('Count', initialValue: 0);
  final value = UiPlaygroundDoubleInput('Value', initialValue: 0.0);
  final color = UiPlaygroundColorInput(
    'Color',
    initialValue: UiPlaygroundTheme.accentColor,
  );
  final dateTime = UiPlaygroundDateTimeInput(
    'Date Time',
    initialValue: DateTime.now(),
  );

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [
    title,
    inputTesterType,
    isEnabled,
    count,
    value,
    color,
    dateTime,
  ];
}
