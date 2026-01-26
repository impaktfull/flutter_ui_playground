import 'package:flutter/material.dart';
import 'package:ui_playground/ui_playground.dart';

class VoidCallbackInput extends UiPlaygroundInputItem<VoidCallback> {
  @override
  VoidCallback? get defaultValue => null;

  VoidCallbackInput(
    super.label,
  );

  @override
  Widget build(BuildContext context) => SizedBox();
}
