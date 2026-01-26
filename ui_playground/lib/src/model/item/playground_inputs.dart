import 'package:flutter/material.dart';
import 'package:ui_playground/src/model/error/input_required_error.dart';

abstract class UiPlaygroundInputs {
  List<UiPlaygroundInputItem<dynamic>>? _inputItems;

  List<UiPlaygroundInputItem<dynamic>> get inputItems => _inputItems ?? [];

  UiPlaygroundInputs();

  @protected
  List<UiPlaygroundInputItem<dynamic>> buildInputItems();

  void setup(VoidCallback listener) {
    _inputItems = buildInputItems();
    for (final item in inputItems) {
      item._addListener(listener);
    }
  }

  void dispose(VoidCallback listener) {
    for (final item in inputItems) {
      item._removeListener(listener);
    }
  }
}

abstract class UiPlaygroundInputItem<T> {
  T? _value;
  T? get value => _value;

  T? get valueOrDefault => value ?? defaultValue;
  T get valueOrDefaultRequired {
    final value = valueOrDefault;
    if (value == null) {
      throw InputRequiredError<T>(label);
    }
    return value;
  }

  final String label;
  final String? extraInfo;
  final _listeners = <VoidCallback>{};

  UiPlaygroundInputItem(
    this.label, {
    T? initialValue,
    this.extraInfo,
  }) : _value = initialValue;

  T? get defaultValue;

  Widget build(BuildContext context);

  void updateState(T? value) {
    _value = value;
    notifyListeners();
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener.call();
    }
  }

  void _addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void _removeListener(VoidCallback listener) => _listeners.remove(listener);
}
