import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundWidgetInput extends UiPlaygroundInputItem<Widget> {
  final List<Widget>? options;
  int? _index;

  int? get _selectedIndex {
    final selectedIndex = _index;
    if (selectedIndex == null) {
      return null;
    }
    final initialValue = this.initialValue;
    if (initialValue == null) {
      return null;
    }
    return options?.indexOf(initialValue);
  }

  @override
  Widget? get defaultValue {
    final index = _selectedIndex;
    if (index == null) return null;
    return options?.elementAtOrNull(index);
  }

  UiPlaygroundWidgetInput(
    super.label, {
    this.options,
    super.initialValue,
    super.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    final options =
        this.options ??
        [
          Text('Widget 1'),
          Text('Widget 2'),
        ];
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
                          child: item,
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
