import 'package:flutter/material.dart';
import 'package:ui_playground/src/model/item/playground_inputs.dart';
import 'package:ui_playground/src/model/item/playground_variant.dart';
import 'package:ui_playground/src/widget/playground/zoom_controls.dart';

class PlaygroundPreview extends StatefulWidget {
  final UiPlaygroundVariant variant;
  final UiPlaygroundInputs inputs;

  const PlaygroundPreview({
    required this.inputs,
    required this.variant,
    super.key,
  });

  @override
  State<PlaygroundPreview> createState() => _PlaygroundPreviewState();
}

class _PlaygroundPreviewState extends State<PlaygroundPreview> {
  final _transformationController = TransformationController();
  final _viewerKey = GlobalKey();
  var _zoomLevel = UiPlaygroundZoomControls.defaultZoom;

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(_onTransformChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformChanged);
    _transformationController.dispose();
    super.dispose();
  }

  void _onTransformChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    if (scale != _zoomLevel) {
      setState(() {
        _zoomLevel = scale;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            key: _viewerKey,
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: UiPlaygroundZoomControls.minZoom,
              maxScale: UiPlaygroundZoomControls.maxZoom,
              boundaryMargin: const EdgeInsets.all(double.infinity),
              child: Center(
                child: widget.variant.build(
                  context,
                  widget.inputs,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: UiPlaygroundZoomControls(
            zoomLevel: _zoomLevel,
            onZoomChanged: _onZoomChanged,
            onReset: _onReset,
          ),
        ),
      ],
    );
  }

  void _onZoomChanged(double zoomLevel) {
    final renderBox =
        _viewerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final viewportSize = renderBox.size;
    final centerX = viewportSize.width / 2;
    final centerY = viewportSize.height / 2;

    final currentMatrix = _transformationController.value;
    final currentScale = currentMatrix.getMaxScaleOnAxis();
    final scaleFactor = zoomLevel / currentScale;

    final translation = currentMatrix.getTranslation();

    final newTranslationX = centerX - (centerX - translation.x) * scaleFactor;
    final newTranslationY = centerY - (centerY - translation.y) * scaleFactor;

    final newMatrix = Matrix4.identity()
      ..translateByDouble(newTranslationX, newTranslationY, 0, 1)
      ..scaleByDouble(zoomLevel, zoomLevel, zoomLevel, 1);

    _transformationController.value = newMatrix;
  }

  void _onReset() {
    _transformationController.value = Matrix4.identity();
  }
}
