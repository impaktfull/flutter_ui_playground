import 'package:flutter/material.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

abstract class UiPlaygroundVariant<T extends UiPlaygroundInputs> {
  String get title;

  const UiPlaygroundVariant();

  Widget build(BuildContext context, T inputs);

  T inputs();
}
