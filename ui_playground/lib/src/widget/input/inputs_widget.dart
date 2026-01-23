import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';

class UiPlaygroundInputsWidget extends StatefulWidget {
  final UiPlaygroundInputs inputs;

  const UiPlaygroundInputsWidget({
    required this.inputs,
    super.key,
  });

  @override
  State<UiPlaygroundInputsWidget> createState() =>
      _UiPlaygroundInputsWidgetState();
}

class _UiPlaygroundInputsWidgetState extends State<UiPlaygroundInputsWidget> {
  late final List<UiPlaygroundInputItem<dynamic>> inputs;

  @override
  void initState() {
    super.initState();
    inputs = widget.inputs.inputItems;
  }

  @override
  Widget build(BuildContext context) {
    if (inputs.isEmpty) return const SizedBox();
    return ImpaktfullUiThemeBuidler(
      builder: (context, theme) => Container(
        color: theme.colors.card,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: inputs.length,
          itemBuilder: (context, index) {
            final input = inputs[index];
            return ImpaktfullUiAutoLayout.vertical(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  input.label,
                  style: theme.textStyles.onCard.text.medium,
                ),
                if (input.extraInfo != null) ...[
                  Text(
                    input.extraInfo!,
                    style:
                        theme.textStyles.onCardTertiary.text.extraSmall.light,
                  ),
                ],
                const SizedBox(height: 4),
                input.build(context),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
