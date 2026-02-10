import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundEnumInput<T extends Enum> extends UiPlaygroundInputItem<T> {
  final List<T> options;

  @override
  T? get defaultValue => options.first;

  UiPlaygroundEnumInput(
    super.label, {
    required super.isNullable,
    required this.options,
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ImpaktfullUiButton(
        type: ImpaktfullUiButtonType.secondary,
        title: value?.name ?? 'null',
        fullWidth: true,
        trailingAsset: const ImpaktfullUiAsset.icon(Icons.arrow_drop_down),
        onTap: () => showDialog<void>(
          context: context,
          builder: (context) => _EnumSelectionDialog<T>(
            label: label,
            options: options,
            isNullable: isNullable,
            currentValue: value,
            onSelected: (selected) {
              updateState(selected);
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}

class _EnumSelectionDialog<T extends Enum> extends StatefulWidget {
  final String label;
  final List<T> options;
  final bool isNullable;
  final T? currentValue;
  final ValueChanged<T?> onSelected;

  const _EnumSelectionDialog({
    required this.label,
    required this.options,
    required this.isNullable,
    required this.currentValue,
    required this.onSelected,
  });

  @override
  State<_EnumSelectionDialog<T>> createState() =>
      _EnumSelectionDialogState<T>();
}

class _EnumSelectionDialogState<T extends Enum>
    extends State<_EnumSelectionDialog<T>> {
  var _searchQuery = '';

  List<T> get _filteredOptions {
    if (_searchQuery.isEmpty) return widget.options;
    return widget.options
        .where(
          (option) =>
              option.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  bool get _showNullOption =>
      widget.isNullable &&
      (_searchQuery.isEmpty || 'null'.contains(_searchQuery.toLowerCase()));

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiThemeBuidler(
      builder: (context, theme) => ImpaktfullUiModal(
        title: widget.label,
        childPadding: EdgeInsets.zero,
        child: SizedBox(
          width: 400,
          height: 500,
          child: ImpaktfullUiAutoLayout.vertical(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: ImpaktfullUiInputField(
                  value: _searchQuery,
                  label: 'Search',
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
              const ImpaktfullUiDivider(),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (_showNullOption) ...[
                      ImpaktfullUiRadioButtonListItem(
                        title: 'null',
                        value: null,
                        groupValue: widget.currentValue,
                        onChanged: (_) => widget.onSelected(null),
                      ),
                    ],
                    for (final option in _filteredOptions) ...[
                      ImpaktfullUiRadioButtonListItem(
                        title: option.name,
                        value: option,
                        groupValue: widget.currentValue,
                        onChanged: (_) => widget.onSelected(option),
                      ),
                    ],
                    if (_filteredOptions.isEmpty && !_showNullOption) ...[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'No matching values',
                            style: theme.textStyles.onCardTertiary.text.small,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
