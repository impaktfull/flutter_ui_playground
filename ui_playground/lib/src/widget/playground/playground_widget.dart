import 'package:flutter/widgets.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';
import 'package:ui_playground/src/model/item/playground_item.dart';
import 'package:ui_playground/src/model/item/playground_variant.dart';
import 'package:ui_playground/src/widget/input/inputs_widget.dart';

class UiPlaygroundWidget extends StatefulWidget {
  final UiPlaygroundItem item;
  final UiPlaygroundVariant variant;

  const UiPlaygroundWidget({
    required this.item,
    required this.variant,
    super.key,
  });

  @override
  State<UiPlaygroundWidget> createState() => _UiPlaygroundWidgetState();
}

class _UiPlaygroundWidgetState extends State<UiPlaygroundWidget> {
  late final UiPlaygroundInputs inputs;

  @override
  void initState() {
    inputs = widget.variant.inputs();
    inputs.setup(_onUpdate);
    super.initState();
  }

  @override
  void dispose() {
    inputs.dispose(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiResponsiveLayout(
      small: (context) => ImpaktfullUiAutoLayout.vertical(
        children: [
          Expanded(
            child: Center(
              child: widget.variant.build(
                context,
                inputs,
              ),
            ),
          ),
          ImpaktfullUiDivider(),
          SizedBox(
            height: 300,
            child: UiPlaygroundInputsWidget(
              key: ValueKey(inputs),
              inputs: inputs,
            ),
          ),
        ],
      ),
      medium: (context) => ImpaktfullUiAutoLayout.horizontal(
        children: [
          Expanded(
            child: Center(
              child: widget.variant.build(
                context,
                inputs,
              ),
            ),
          ),
          ImpaktfullUiDivider(vertical: true),
          SizedBox(
            width: 350,
            child: UiPlaygroundInputsWidget(
              key: ValueKey(inputs),
              inputs: inputs,
            ),
          ),
        ],
      ),
    );
  }

  void _onUpdate() {
    setState(() {});
  }
}
