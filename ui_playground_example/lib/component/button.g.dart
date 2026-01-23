// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// UiPlaygroundComponentGenerator
// **************************************************************************

/// Generated UiPlaygroundItem for Button
class ButtonPlaygroundItem extends UiPlaygroundItem {
  @override
  String get title => 'Button';

  @override
  List<UiPlaygroundVariant> get variants => [ButtonPlaygroundVariant()];
}

/// Generated UiPlaygroundVariant for Button
class ButtonPlaygroundVariant
    extends UiPlaygroundVariant<ButtonPlaygroundInputs> {
  @override
  String get title => 'Default';

  @override
  Widget build(BuildContext context, ButtonPlaygroundInputs inputs) {
    return Button(title: inputs.title.value ?? '');
  }

  @override
  ButtonPlaygroundInputs inputs() => ButtonPlaygroundInputs();
}

/// Generated UiPlaygroundInputs for Button
class ButtonPlaygroundInputs extends UiPlaygroundInputs {
  final title = UiPlaygroundStringInput('Title', initialValue: '{title}');

  @override
  List<UiPlaygroundInputItem<dynamic>> buildInputItems() => [title];
}
