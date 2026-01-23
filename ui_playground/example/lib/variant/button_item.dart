import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';

class ButtonItem extends UiPlaygroundItem {
  @override
  String get title => 'Button';

  @override
  List<UiPlaygroundVariant> get variants => [
    for (final variant in ImpaktfullUiButtonType.values) ...[
      ButtonVariant(type: variant),
    ],
  ];
}

class ButtonVariant extends UiPlaygroundVariant<ButtonInputs> {
  final ImpaktfullUiButtonType type;

  ButtonVariant({
    required this.type,
  });

  @override
  String get title => type.name;

  @override
  Widget build(BuildContext context, ButtonInputs inputs) => ImpaktfullUiButton(
    type: type,
    title: inputs.title.value,
    size: inputs.size.value!,
    leadingAsset: inputs.leading.value == null
        ? null
        : ImpaktfullUiAsset.icon(inputs.leading.value!),
    trailingAsset: inputs.trailingIcon.value == null
        ? null
        : ImpaktfullUiAsset.icon(inputs.trailingIcon.value!),
    onAsyncTap: () async {
      await Future.delayed(const Duration(seconds: 1));
    },
  );

  @override
  ButtonInputs inputs() => ButtonInputs();
}

class ButtonInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput(
    'Title',
    initialValue: '{title}',
  );
  final size = UiPlaygroundEnumInput<ImpaktfullUiButtonSize>(
    'Size',
    initialValue: ImpaktfullUiButtonSize.medium,
    options: ImpaktfullUiButtonSize.values,
  );

  final leading = UiPlaygroundIconInput(
    'Leading Icon',
    initialValue: null,
  );

  final trailingIcon = UiPlaygroundIconInput(
    'Trailing Icon',
    initialValue: null,
  );

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [
    title,
    size,
    leading,
    trailingIcon,
  ];
}
