import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

/// A factory function that creates a new input item for a list element.
typedef InputItemBuilder<T> = UiPlaygroundInputItem<T> Function(String label);

/// A generic list input that wraps any input type and allows adding/removing items.
///
/// Usage:
/// ```dart
/// final items = UiPlaygroundListInput<String>(
///   'Items',
///   inputBuilder: (label) => UiPlaygroundStringInput(label),
/// );
/// ```
class UiPlaygroundListInput<T> extends UiPlaygroundInputItem<List<T>> {
  final InputItemBuilder<T> inputBuilder;
  final List<UiPlaygroundInputItem<T>> _childInputs = [];
  int _counter = 0;

  @override
  List<T>? get defaultValue => const [];

  UiPlaygroundListInput(
    super.label, {
    required this.inputBuilder,
    List<T>? initialValue,
    super.extraInfo,
  }) : super(initialValue: initialValue) {
    // Initialize with initial values if provided
    if (initialValue != null) {
      for (final item in initialValue) {
        _addItem(itemValue: item);
      }
    }
  }

  void _addItem({T? itemValue}) {
    _counter++;
    final input = inputBuilder('Item $_counter');
    if (itemValue != null) {
      input.updateState(itemValue);
    }
    input.addListener(_onChildChanged);
    _childInputs.add(input);
  }

  void _removeItem(int index) {
    if (index >= 0 && index < _childInputs.length) {
      _childInputs[index].removeListener(_onChildChanged);
      _childInputs.removeAt(index);
      _onChildChanged();
    }
  }

  void _onChildChanged() {
    // Aggregate all child values into a list
    final values = <T>[];
    for (final input in _childInputs) {
      final value = input.value;
      if (value != null) {
        values.add(value);
      }
    }
    super.updateState(values.isEmpty ? null : values);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return ImpaktfullUiThemeBuidler(
          builder: (context, theme) => ImpaktfullUiAutoLayout.vertical(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              for (var i = 0; i < _childInputs.length; i++) ...[
                ImpaktfullUiAutoLayout.horizontal(
                  spacing: 4,
                  children: [
                    Expanded(child: _childInputs[i].build(context)),
                    ImpaktfullUiIconButton(
                      asset: const ImpaktfullUiAsset.icon(
                        Icons.remove_circle_outline_rounded,
                      ),
                      onTap: () {
                        setState(() => _removeItem(i));
                      },
                    ),
                  ],
                ),
              ],
              ImpaktfullUiButton(
                type: ImpaktfullUiButtonType.secondaryGrey,
                title: 'Add item',
                fullWidth: true,
                onAsyncTap: () async {
                  setState(() => _addItem());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void updateState(List<T>? value) {
    super.updateState(value);
    // Clear existing items
    for (final input in _childInputs) {
      input.removeListener(_onChildChanged);
    }
    _childInputs.clear();
    _counter = 0;

    // Add new items
    if (value == null) return;
    for (final item in value) {
      _addItem(itemValue: item);
    }
  }
}
