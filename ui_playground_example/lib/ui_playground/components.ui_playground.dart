// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// UiPlaygroundAggregatingGenerator
// **************************************************************************

// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';
import 'package:impaktfull_ui/src/components/divider/divider.dart';
import 'package:ui_playground_example/component/button.dart';
import 'package:ui_playground_example/component/input_tester.dart';

// **************************************************************************
// GeneratedUiPlaygroundComponents
// **************************************************************************

class GeneratedUiPlaygroundComponents {
  GeneratedUiPlaygroundComponents._();

  static List<UiPlaygroundItem> get items => [
    ImpaktfullUiDividerPlaygroundItem(),
    ButtonPlaygroundItem(),
    InputTesterPlaygroundItem(),
  ];
}

// **************************************************************************
// ImpaktfullUiDivider
// **************************************************************************

class ImpaktfullUiDividerPlaygroundItem extends UiPlaygroundItem {
  @override
  String get title => 'ImpaktfullUiDivider';

  @override
  List<UiPlaygroundVariant> get variants => [
    ImpaktfullUiDividerPlaygroundVariant(),
  ];
}

class ImpaktfullUiDividerPlaygroundVariant
    extends UiPlaygroundVariant<ImpaktfullUiDividerPlaygroundInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(
    BuildContext context,
    ImpaktfullUiDividerPlaygroundInputs inputs,
  ) {
    return ImpaktfullUiDivider(
      vertical: inputs.vertical.valueOrDefaultRequired,
    );
  }

  @override
  ImpaktfullUiDividerPlaygroundInputs inputs() =>
      ImpaktfullUiDividerPlaygroundInputs();
}

class ImpaktfullUiDividerPlaygroundInputs extends UiPlaygroundInputs {
  final vertical = UiPlaygroundBooleanInput('Vertical', initialValue: false);

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [vertical];
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
    return Button(title: inputs.title.valueOrDefaultRequired);
  }

  @override
  ButtonPlaygroundInputs inputs() => ButtonPlaygroundInputs();
}

class ButtonPlaygroundInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title');

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
      title: inputs.title.valueOrDefaultRequired,
      inputTesterType: inputs.inputTesterType.valueOrDefaultRequired,
      isEnabled: inputs.isEnabled.valueOrDefaultRequired,
      count: inputs.count.valueOrDefaultRequired,
      value: inputs.value.valueOrDefaultRequired,
      color: inputs.color.valueOrDefaultRequired,
      dateTime: inputs.dateTime.valueOrDefaultRequired,
      edgeInsets: inputs.edgeInsets.valueOrDefaultRequired,
      edgeInsetsGeometry: inputs.edgeInsetsGeometry.valueOrDefaultRequired,
    );
  }

  @override
  InputTesterPlaygroundInputs inputs() => InputTesterPlaygroundInputs();
}

class InputTesterPlaygroundInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title');
  final inputTesterType = UiPlaygroundEnumInput<InputTesterType>(
    'Input Tester Type',
    options: InputTesterType.values,
  );
  final isEnabled = UiPlaygroundBooleanInput('Is Enabled');
  final count = UiPlaygroundIntInput('Count');
  final value = UiPlaygroundDoubleInput('Value');
  final color = UiPlaygroundColorInput('Color');
  final dateTime = UiPlaygroundDateTimeInput('Date Time');
  final edgeInsets = UiPlaygroundEdgeInsetInput('Edge Insets');
  final edgeInsetsGeometry = UiPlaygroundEdgeInsetGeometryInput(
    'Edge Insets Geometry',
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
    edgeInsets,
    edgeInsetsGeometry,
  ];
}
