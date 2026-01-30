import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';
import 'package:ui_playground_example/component/button.dart';

enum InputTesterType {
  value1,
  value2,
  value3,
}

@UiPlaygroundComponent(
  title: 'Input Tester',
)
class InputTester extends StatefulWidget {
  final Widget child;
  final String title;
  final bool isEnabled;
  final int count;
  final double value;
  final Color color;
  final DateTime dateTime;
  final InputTesterType inputTesterType;
  final EdgeInsets edgeInsets;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final List<String> tags;
  final VoidCallback? onPressed;
  final VoidCallback onPressedRequired;
  final void Function(int index, String name)? onItemSelected;
  final void Function(int index, String name) onItemSelectedRequired;

  const InputTester({
    required this.child,
    required this.title,
    required this.inputTesterType,
    required this.isEnabled,
    required this.count,
    required this.value,
    required this.color,
    required this.dateTime,
    required this.edgeInsets,
    required this.edgeInsetsGeometry,
    required this.tags,
    required this.onPressedRequired,
    required this.onItemSelectedRequired,
    this.onPressed,
    this.onItemSelected,
    super.key,
  });

  @override
  State<InputTester> createState() => _InputTesterState();
}

class _InputTesterState extends State<InputTester> {
  int _indexRequired = 0;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ImpaktfullUiAutoLayout.vertical(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          _InputTesterListItem(
            title: 'Widget',
            widget: widget.child,
          ),
          _InputTesterListItem(
            title: 'Title',
            value: widget.title,
          ),
          _InputTesterListItem(
            title: 'Input Tester Type',
            value: widget.inputTesterType,
          ),
          _InputTesterListItem(
            title: 'Is Enabled',
            value: widget.isEnabled,
          ),
          _InputTesterListItem(
            title: 'Count',
            value: widget.count,
          ),
          _InputTesterListItem(
            title: 'Value',
            value: widget.value,
          ),
          _InputTesterListItem(
            title: 'Color',
            widget: Container(
              width: 24,
              height: 24,
              color: widget.color,
            ),
          ),
          _InputTesterListItem(
            title: 'Date Time',
            value: widget.dateTime,
          ),
          _InputTesterListItem(
            title: 'EdgeInsets',
            value: widget.edgeInsets,
          ),
          _InputTesterListItem(
            title: 'EdgeInsetsGeometry',
            value: widget.edgeInsetsGeometry,
          ),
          _InputTesterListItem(
            title: 'Tags',
            value: widget.tags.join(', '),
          ),
          Button(
            title: 'On Pressed Required',
            fullWidth: true,
            onTap: widget.onPressedRequired,
          ),
          ImpaktfullUiSeparatedColumn(
            children: [
              ImpaktfullUiRadioButtonListItem(
                title: 'Item 1',
                value: 0,
                groupValue: _indexRequired,
                onChanged: (value) {
                  setState(() => _indexRequired = value);
                  widget.onItemSelectedRequired(value, 'Item $value');
                },
              ),
              ImpaktfullUiRadioButtonListItem(
                title: 'Item 1',
                value: 1,
                groupValue: _indexRequired,
                onChanged: (value) {
                  setState(() => _indexRequired = value);
                  widget.onItemSelectedRequired(value, 'Item $value');
                },
              ),
            ],
          ),
          Button(
            title: 'On Pressed',
            fullWidth: true,
            onTap: widget.onPressed,
          ),
          ImpaktfullUiSeparatedColumn(
            children: [
              ImpaktfullUiRadioButtonListItem(
                title: 'Item 1',
                value: 0,
                groupValue: _index,
                onChanged: (value) {
                  setState(() => _index = value);
                  widget.onItemSelected?.call(value, 'Item $value');
                },
              ),
              ImpaktfullUiRadioButtonListItem(
                title: 'Item 1',
                value: 1,
                groupValue: _index,
                onChanged: (value) {
                  setState(() => _index = value);
                  widget.onItemSelected?.call(value, 'Item $value');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InputTesterListItem extends StatelessWidget {
  final String title;
  final Object? value;
  final Widget? widget;

  const _InputTesterListItem({
    required this.title,
    this.value,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiAutoLayout.horizontal(
      children: [
        Expanded(child: Text(title)),
        if (widget != null) widget!,
        if (value != null) Text(value.toString()),
      ],
    );
  }
}
