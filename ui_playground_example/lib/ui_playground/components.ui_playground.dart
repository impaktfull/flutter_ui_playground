// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// UiPlaygroundAggregatingGenerator
// **************************************************************************

// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';
import 'package:impaktfull_ui/src/components/button/button.dart';
import 'package:impaktfull_ui/src/components/divider/divider.dart';
import 'package:impaktfull_ui/src/components/list_view/list_view.dart';
import 'package:ui_playground_example/component/button.dart';
import 'package:ui_playground_example/component/input_tester.dart';

// **************************************************************************
// GeneratedUiPlaygroundComponents
// **************************************************************************

class GeneratedUiPlaygroundComponents {
  GeneratedUiPlaygroundComponents._();

  static List<UiPlaygroundItem> get items => [
    ImpaktfullUiDividerPlaygroundItem(),
    ImpaktfullUiButtonPlaygroundItem(),
    ImpaktfullUiListViewPlaygroundItem(),
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
      margin: inputs.margin.valueOrDefault,
      vertical: inputs.vertical.valueOrDefaultRequired,
    );
  }

  @override
  ImpaktfullUiDividerPlaygroundInputs inputs() =>
      ImpaktfullUiDividerPlaygroundInputs();
}

class ImpaktfullUiDividerPlaygroundInputs extends UiPlaygroundInputs {
  final margin = UiPlaygroundEdgeInsetsGeometryInput('Margin');
  final vertical = UiPlaygroundBooleanInput('Vertical', initialValue: false);

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [margin, vertical];
}

// **************************************************************************
// ImpaktfullUiButton
// **************************************************************************

class ImpaktfullUiButtonPlaygroundItem extends UiPlaygroundItem {
  @override
  String get title => 'ImpaktfullUiButton';

  @override
  List<UiPlaygroundVariant> get variants => [
    ImpaktfullUiButtonPlaygroundVariant(),
  ];
}

class ImpaktfullUiButtonPlaygroundVariant
    extends UiPlaygroundVariant<ImpaktfullUiButtonPlaygroundInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(
    BuildContext context,
    ImpaktfullUiButtonPlaygroundInputs inputs,
  ) {
    return ImpaktfullUiButton(
      type: inputs.type.valueOrDefaultRequired,
      title: inputs.title.valueOrDefault,
      size: inputs.size.valueOrDefaultRequired,
      leadingAsset: inputs.leadingAsset.valueOrDefault,
      leadingChild: inputs.leadingChild.valueOrDefault,
      trailingAsset: inputs.trailingAsset.valueOrDefault,
      trailingChild: inputs.trailingChild.valueOrDefault,
      fullWidth: inputs.fullWidth.valueOrDefaultRequired,
      isLoading: inputs.isLoading.valueOrDefaultRequired,
      canRequestFocus: inputs.canRequestFocus.valueOrDefaultRequired,
      tooltip: inputs.tooltip.valueOrDefault,
    );
  }

  @override
  ImpaktfullUiButtonPlaygroundInputs inputs() =>
      ImpaktfullUiButtonPlaygroundInputs();
}

class ImpaktfullUiButtonPlaygroundInputs extends UiPlaygroundInputs {
  final type = UiPlaygroundEnumInput<ImpaktfullUiButtonType>(
    'Type',
    options: ImpaktfullUiButtonType.values,
  );
  final title = UiPlaygroundStringInput('Title');
  final size = UiPlaygroundEnumInput<ImpaktfullUiButtonSize>(
    'Size',
    initialValue: ImpaktfullUiButtonSize.medium,
    options: ImpaktfullUiButtonSize.values,
  );
  final leadingAsset = UiPlaygroundImpaktfullUiAssetInput('Leading Asset');
  final leadingChild = UiPlaygroundWidgetInput('Leading Child');
  final trailingAsset = UiPlaygroundImpaktfullUiAssetInput('Trailing Asset');
  final trailingChild = UiPlaygroundWidgetInput('Trailing Child');
  final fullWidth = UiPlaygroundBooleanInput('Full Width', initialValue: false);
  final isLoading = UiPlaygroundBooleanInput('Is Loading', initialValue: false);
  final canRequestFocus = UiPlaygroundBooleanInput(
    'Can Request Focus',
    initialValue: true,
  );
  final tooltip = UiPlaygroundStringInput('Tooltip');

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [
    type,
    title,
    size,
    leadingAsset,
    leadingChild,
    trailingAsset,
    trailingChild,
    fullWidth,
    isLoading,
    canRequestFocus,
    tooltip,
  ];
}

// **************************************************************************
// ImpaktfullUiListView
// **************************************************************************

class ImpaktfullUiListViewPlaygroundItem extends UiPlaygroundItem {
  @override
  String get title => 'ImpaktfullUiListView';

  @override
  List<UiPlaygroundVariant> get variants => [
    ImpaktfullUiListViewPlaygroundVariant(),
  ];
}

class ImpaktfullUiListViewPlaygroundVariant
    extends UiPlaygroundVariant<ImpaktfullUiListViewPlaygroundInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(
    BuildContext context,
    ImpaktfullUiListViewPlaygroundInputs inputs,
  ) {
    return ImpaktfullUiListView(
      isLoading: inputs.isLoading.valueOrDefaultRequired,
      useSafeArea: inputs.useSafeArea.valueOrDefaultRequired,
      spacing: inputs.spacing.valueOrDefaultRequired,
      itemsPerRow: inputs.itemsPerRow.valueOrDefaultRequired,
      padding: inputs.padding.valueOrDefaultRequired,
      shrinkWrap: inputs.shrinkWrap.valueOrDefaultRequired,
      reversed: inputs.reversed.valueOrDefaultRequired,
      scrollDirection: inputs.scrollDirection.valueOrDefaultRequired,
      children: inputs.children.valueOrDefaultRequired,
    );
  }

  @override
  ImpaktfullUiListViewPlaygroundInputs inputs() =>
      ImpaktfullUiListViewPlaygroundInputs();
}

class ImpaktfullUiListViewPlaygroundInputs extends UiPlaygroundInputs {
  final children = UiPlaygroundListInput<Widget>(
    'Children',
    inputBuilder: (label) => UiPlaygroundWidgetInput(label),
  );
  final isLoading = UiPlaygroundBooleanInput('Is Loading', initialValue: false);
  final useSafeArea = UiPlaygroundBooleanInput(
    'Use Safe Area',
    initialValue: true,
  );
  final spacing = UiPlaygroundDoubleInput('Spacing', initialValue: 0);
  final itemsPerRow = UiPlaygroundIntInput('Items Per Row', initialValue: 1);
  final padding = UiPlaygroundEdgeInsetsGeometryInput(
    'Padding',
    initialValue: EdgeInsetsDirectional.zero,
  );
  final shrinkWrap = UiPlaygroundBooleanInput(
    'Shrink Wrap',
    initialValue: false,
  );
  final reversed = UiPlaygroundBooleanInput('Reversed', initialValue: false);
  final scrollDirection = UiPlaygroundEnumInput<Axis>(
    'Scroll Direction',
    initialValue: Axis.vertical,
    options: Axis.values,
  );

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [
    children,
    isLoading,
    useSafeArea,
    spacing,
    itemsPerRow,
    padding,
    shrinkWrap,
    reversed,
    scrollDirection,
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
      tags: inputs.tags.valueOrDefaultRequired,
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
  final edgeInsets = UiPlaygroundEdgeInsetsInput('Edge Insets');
  final edgeInsetsGeometry = UiPlaygroundEdgeInsetsGeometryInput(
    'Edge Insets Geometry',
  );
  final tags = UiPlaygroundListInput<String>(
    'Tags',
    inputBuilder: (label) => UiPlaygroundStringInput(label),
    initialValue: const [],
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
    tags,
  ];
}
