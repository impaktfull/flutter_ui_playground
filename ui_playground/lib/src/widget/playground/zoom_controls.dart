import 'package:flutter/material.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

class UiPlaygroundZoomControls extends StatelessWidget {
  static const double defaultZoom = 1.0;
  static const double minZoom = 0.25;
  static const double maxZoom = 4.0;
  static const double zoomStep = 0.25;

  final double zoomLevel;
  final ValueChanged<double> onZoomChanged;
  final VoidCallback? onReset;

  const UiPlaygroundZoomControls({
    required this.zoomLevel,
    required this.onZoomChanged,
    this.onReset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final canZoomOut = zoomLevel > minZoom;
    final canZoomIn = zoomLevel < maxZoom;
    return ImpaktfullUiAutoLayout.horizontal(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: canZoomOut ? 1.0 : 0.5,
          child: ImpaktfullUiIconButton(
            asset: const ImpaktfullUiAsset.icon(Icons.remove_rounded),
            onTap: canZoomOut ? _zoomOut : () {},
          ),
        ),
        ImpaktfullUiTouchFeedback(
          onTap: _resetZoom,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            constraints: const BoxConstraints(minWidth: 56),
            decoration: BoxDecoration(
              color: theme.colors.card,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: theme.colors.border),
            ),
            child: Center(
              child: Text(
                '${(zoomLevel * 100).round()}%',
                style: theme.textStyles.onCard.text.small,
              ),
            ),
          ),
        ),
        Opacity(
          opacity: canZoomIn ? 1.0 : 0.5,
          child: ImpaktfullUiIconButton(
            asset: const ImpaktfullUiAsset.icon(Icons.add_rounded),
            onTap: canZoomIn ? _zoomIn : () {},
          ),
        ),
      ],
    );
  }

  void _zoomIn() {
    final newZoom = (zoomLevel + zoomStep).clamp(minZoom, maxZoom);
    onZoomChanged(newZoom);
  }

  void _zoomOut() {
    final newZoom = (zoomLevel - zoomStep).clamp(minZoom, maxZoom);
    onZoomChanged(newZoom);
  }

  void _resetZoom() {
    if (onReset != null) {
      onReset!();
    } else {
      onZoomChanged(defaultZoom);
    }
  }
}
