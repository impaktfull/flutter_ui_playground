// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// UiPlaygroundAggregatingGenerator
// **************************************************************************

// ignore_for_file: implementation_imports, sort_child_properties_last
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
  final margin = UiPlaygroundEdgeInsetsGeometryInput(
    'Margin',
    isNullable: true,
  );
  final vertical = UiPlaygroundBooleanInput(
    'Vertical',
    isNullable: false,
    initialValue: false,
  );

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
      onTap: () => UiPlaygroundNotification.show(context, 'onTap()'),
      onAsyncTap: () async =>
          UiPlaygroundNotification.show(context, 'onAsyncTap()'),
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
    isNullable: false,
    options: ImpaktfullUiButtonType.values,
  );
  final title = UiPlaygroundStringInput('Title', isNullable: true);
  final size = UiPlaygroundEnumInput<ImpaktfullUiButtonSize>(
    'Size',
    isNullable: false,
    initialValue: ImpaktfullUiButtonSize.medium,
    options: ImpaktfullUiButtonSize.values,
  );
  final leadingAsset = UiPlaygroundImpaktfullUiAssetInput(
    'Leading Asset',
    isNullable: true,
  );
  final leadingChild = UiPlaygroundWidgetInput(
    'Leading Child',
    isNullable: true,
  );
  final trailingAsset = UiPlaygroundImpaktfullUiAssetInput(
    'Trailing Asset',
    isNullable: true,
  );
  final trailingChild = UiPlaygroundWidgetInput(
    'Trailing Child',
    isNullable: true,
  );
  final fullWidth = UiPlaygroundBooleanInput(
    'Full Width',
    isNullable: false,
    initialValue: false,
  );
  final isLoading = UiPlaygroundBooleanInput(
    'Is Loading',
    isNullable: false,
    initialValue: false,
  );
  final canRequestFocus = UiPlaygroundBooleanInput(
    'Can Request Focus',
    isNullable: false,
    initialValue: true,
  );
  final onTap = UiPlaygroundCallbackInput('On Tap', isNullable: true);
  final onAsyncTap = UiPlaygroundCallbackInput(
    'On Async Tap',
    isNullable: true,
  );
  final tooltip = UiPlaygroundStringInput('Tooltip', isNullable: true);

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
    onTap,
    onAsyncTap,
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
      children: inputs.children.valueOrDefaultRequired,
      isLoading: inputs.isLoading.valueOrDefaultRequired,
      useSafeArea: inputs.useSafeArea.valueOrDefaultRequired,
      spacing: inputs.spacing.valueOrDefaultRequired,
      onRefresh: () async =>
          UiPlaygroundNotification.show(context, 'onRefresh()'),
      itemsPerRow: inputs.itemsPerRow.valueOrDefaultRequired,
      padding: inputs.padding.valueOrDefaultRequired,
      shrinkWrap: inputs.shrinkWrap.valueOrDefaultRequired,
      reversed: inputs.reversed.valueOrDefaultRequired,
      scrollDirection: inputs.scrollDirection.valueOrDefaultRequired,
      leadingBuilder: (context) => null,
      trailingBuilder: (context) => null,
    );
  }

  @override
  ImpaktfullUiListViewPlaygroundInputs inputs() =>
      ImpaktfullUiListViewPlaygroundInputs();
}

class ImpaktfullUiListViewPlaygroundInputs extends UiPlaygroundInputs {
  final children = UiPlaygroundListInput<Widget>(
    'Children',
    isNullable: false,
    inputBuilder: (label) => UiPlaygroundWidgetInput(label, isNullable: false),
  );
  final isLoading = UiPlaygroundBooleanInput(
    'Is Loading',
    isNullable: false,
    initialValue: false,
  );
  final useSafeArea = UiPlaygroundBooleanInput(
    'Use Safe Area',
    isNullable: false,
    initialValue: true,
  );
  final spacing = UiPlaygroundDoubleInput(
    'Spacing',
    isNullable: false,
    initialValue: 0,
  );
  final onRefresh = UiPlaygroundCallbackInput('On Refresh', isNullable: true);
  final itemsPerRow = UiPlaygroundIntInput(
    'Items Per Row',
    isNullable: false,
    initialValue: 1,
  );
  final padding = UiPlaygroundEdgeInsetsGeometryInput(
    'Padding',
    isNullable: false,
    initialValue: EdgeInsetsDirectional.zero,
  );
  final shrinkWrap = UiPlaygroundBooleanInput(
    'Shrink Wrap',
    isNullable: false,
    initialValue: false,
  );
  final reversed = UiPlaygroundBooleanInput(
    'Reversed',
    isNullable: false,
    initialValue: false,
  );
  final scrollDirection = UiPlaygroundEnumInput<Axis>(
    'Scroll Direction',
    isNullable: false,
    initialValue: Axis.vertical,
    options: Axis.values,
  );
  final leadingBuilder = UiPlaygroundCallbackInput(
    'Leading Builder',
    isNullable: true,
    parameterNames: ['context'],
  );
  final trailingBuilder = UiPlaygroundCallbackInput(
    'Trailing Builder',
    isNullable: true,
    parameterNames: ['context'],
  );

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [
    children,
    isLoading,
    useSafeArea,
    spacing,
    onRefresh,
    itemsPerRow,
    padding,
    shrinkWrap,
    reversed,
    scrollDirection,
    leadingBuilder,
    trailingBuilder,
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
    return Button(
      title: inputs.title.valueOrDefaultRequired,
      onTap: () => UiPlaygroundNotification.show(context, 'onTap()'),
      fullWidth: inputs.fullWidth.valueOrDefaultRequired,
    );
  }

  @override
  ButtonPlaygroundInputs inputs() => ButtonPlaygroundInputs();
}

class ButtonPlaygroundInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title', isNullable: false);
  final onTap = UiPlaygroundCallbackInput('On Tap', isNullable: true);
  final fullWidth = UiPlaygroundBooleanInput(
    'Full Width',
    isNullable: false,
    initialValue: false,
  );

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [
    title,
    onTap,
    fullWidth,
  ];
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
      child: inputs.child.valueOrDefaultRequired,
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
      onPressedRequired: () =>
          UiPlaygroundNotification.show(context, 'onPressedRequired()'),
      onItemSelectedRequired: (index, name) => UiPlaygroundNotification.show(
        context,
        'onItemSelectedRequired(index: $index, name: $name)',
      ),
      onPressed: () => UiPlaygroundNotification.show(context, 'onPressed()'),
      onItemSelected: (index, name) => UiPlaygroundNotification.show(
        context,
        'onItemSelected(index: $index, name: $name)',
      ),
    );
  }

  @override
  InputTesterPlaygroundInputs inputs() => InputTesterPlaygroundInputs();
}

class InputTesterPlaygroundInputs extends UiPlaygroundInputs {
  final child = UiPlaygroundWidgetInput('Child', isNullable: false);
  final title = UiPlaygroundStringInput('Title', isNullable: false);
  final inputTesterType = UiPlaygroundEnumInput<InputTesterType>(
    'Input Tester Type',
    isNullable: false,
    options: InputTesterType.values,
  );
  final isEnabled = UiPlaygroundBooleanInput('Is Enabled', isNullable: false);
  final count = UiPlaygroundIntInput('Count', isNullable: false);
  final value = UiPlaygroundDoubleInput('Value', isNullable: false);
  final color = UiPlaygroundColorInput('Color', isNullable: false);
  final dateTime = UiPlaygroundDateTimeInput('Date Time', isNullable: false);
  final edgeInsets = UiPlaygroundEdgeInsetsInput(
    'Edge Insets',
    isNullable: false,
  );
  final edgeInsetsGeometry = UiPlaygroundEdgeInsetsGeometryInput(
    'Edge Insets Geometry',
    isNullable: false,
  );
  final tags = UiPlaygroundListInput<String>(
    'Tags',
    isNullable: false,
    inputBuilder: (label) => UiPlaygroundStringInput(label, isNullable: false),
  );
  final onPressedRequired = UiPlaygroundCallbackInput(
    'On Pressed Required',
    isNullable: false,
  );
  final onItemSelectedRequired = UiPlaygroundCallbackInput(
    'On Item Selected Required',
    isNullable: false,
    parameterNames: ['index', 'name'],
  );
  final onPressed = UiPlaygroundCallbackInput('On Pressed', isNullable: true);
  final onItemSelected = UiPlaygroundCallbackInput(
    'On Item Selected',
    isNullable: true,
    parameterNames: ['index', 'name'],
  );

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [
    child,
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
    onPressedRequired,
    onItemSelectedRequired,
    onPressed,
    onItemSelected,
  ];
}
