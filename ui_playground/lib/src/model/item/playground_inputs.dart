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
  @protected
  final T? initialValue;
  T? _value;
  T? get value => _value;

  T? get valueOrDefault {
    final value = this.value ?? defaultValue;
    if (value == null && isNullable) {
      return null;
    } else if (value == null) {
      throw InputRequiredError<T>(label);
    }
    return value;
  }

  T get valueOrDefaultRequired {
    final value = valueOrDefault;
    if (value == null) {
      throw InputRequiredError<T>(label);
    }
    return value;
  }

  final bool isNullable;

  final String label;
  final String? extraInfo;
  final _listeners = <VoidCallback>{};

  UiPlaygroundInputItem(this.label, {required this.isNullable, this.initialValue, this.extraInfo}) : _value = initialValue;

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

  /// Adds a listener that will be called when the value changes.
  /// This is primarily used internally by [UiPlaygroundInputs].
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Removes a previously added listener.
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  // Keep private aliases for backwards compatibility with UiPlaygroundInputs
  void _addListener(VoidCallback listener) => addListener(listener);
  void _removeListener(VoidCallback listener) => removeListener(listener);
}
