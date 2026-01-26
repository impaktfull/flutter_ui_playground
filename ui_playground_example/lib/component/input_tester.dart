import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/ui_playground.dart';

enum InputTesterType {
  value1,
  value2,
  value3,
}

@UiPlaygroundComponent(
  title: 'Input Tester',
)
class InputTester extends StatelessWidget {
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

  const InputTester({
    required this.title,
    required this.inputTesterType,
    required this.isEnabled,
    required this.count,
    required this.value,
    required this.color,
    required this.dateTime,
    required this.edgeInsets,
    required this.edgeInsetsGeometry,
    this.tags = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ImpaktfullUiAutoLayout.vertical(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          _InputTesterListItem(
            title: 'Title',
            value: title,
          ),
          _InputTesterListItem(
            title: 'Input Tester Type',
            value: inputTesterType,
          ),
          _InputTesterListItem(
            title: 'Is Enabled',
            value: isEnabled,
          ),
          _InputTesterListItem(
            title: 'Count',
            value: count,
          ),
          _InputTesterListItem(
            title: 'Value',
            value: value,
          ),
          _InputTesterListItem(
            title: 'Color',
            widget: Container(
              width: 24,
              height: 24,
              color: color,
            ),
          ),
          _InputTesterListItem(
            title: 'Date Time',
            value: dateTime,
          ),
          _InputTesterListItem(
            title: 'EdgeInsets',
            value: edgeInsets,
          ),
          _InputTesterListItem(
            title: 'EdgeInsetsGeometry',
            value: edgeInsetsGeometry,
          ),
          _InputTesterListItem(
            title: 'Tags',
            value: tags.join(', '),
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
