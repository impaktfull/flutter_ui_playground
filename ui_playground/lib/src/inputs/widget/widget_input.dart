import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';

class UiPlaygroundWidgetInput extends UiPlaygroundInputItem<Widget> {
  late final List<Widget> _fallbackOptions = [
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: UiPlaygroundTheme.accentColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        'Widget 1',
        textAlign: TextAlign.center,
        style: UiPlaygroundTheme.textOnAccentColor,
      ),
    ),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: UiPlaygroundTheme.secondaryColor,
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        'Widget 2',
        textAlign: TextAlign.center,
        style: UiPlaygroundTheme.textOnSecondaryColor,
      ),
    ),
  ];
  final List<Widget>? _options;
  List<Widget?> get options {
    return [
      if (isNullable) ...[null],
      ...(_options ?? _fallbackOptions),
    ];
  }

  int? _index;

  int? get _selectedIndex {
    var selectedIndex = _index;
    if (isNullable) {
      return null;
    }
    selectedIndex ??= 0;
    final initialValue = this.initialValue;
    if (initialValue != null) {
      return options.indexOf(initialValue);
    }
    return selectedIndex;
  }

  @override
  Widget? get defaultValue {
    final index = _selectedIndex;
    if (index == null) return null;
    return options.elementAtOrNull(index);
  }

  UiPlaygroundWidgetInput(
    super.label, {
    required super.isNullable,
    List<Widget>? options,
    super.initialValue,
    super.extraInfo,
  }) : _options = options;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ImpaktfullUiSeparatedColumn(
        children: [
          for (var i = 0; i < options.length; i++) ...[
            Builder(
              builder: (context) {
                final item = options[i];
                return ImpaktfullUiTouchFeedback(
                  onTap: () {
                    _index = i;
                    updateState(item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ImpaktfullUiAutoLayout.horizontal(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: item ?? Text('null'),
                        ),
                        IgnorePointer(
                          child: ImpaktfullUiRadioButton(
                            value: i,
                            groupValue: _index,
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
