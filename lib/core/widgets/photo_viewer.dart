import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({super.key, required this.photos, this.initialIndex = 0});

  final List<String> photos;
  final int initialIndex;

  static Future<void> open(
    BuildContext context, {
    required List<String> photos,
    int initialIndex = 0,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            PhotoViewer(photos: photos, initialIndex: initialIndex),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  static String heroTag(String path) => 'photo-$path';

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late final PageController _pageController;
  late final List<TransformationController> _zoomControllers;
  late int _index;
  bool _isZoomed = false;
  Offset _doubleTapPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _zoomControllers = [
      for (final _ in widget.photos) TransformationController(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final controller in _zoomControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateZoomState() {
    final scale = _zoomControllers[_index].value.getMaxScaleOnAxis();
    setState(() => _isZoomed = scale > 1.01);
  }

  void _onDoubleTap() {
    final controller = _zoomControllers[_index];
    if (_isZoomed) {
      controller.value = Matrix4.identity();
    } else {
      final p = _doubleTapPosition;
      controller.value = Matrix4.identity()
        ..translateByDouble(-p.dx, -p.dy, 0, 1)
        ..scaleByDouble(2, 2, 1, 1);
    }
    _updateZoomState();
  }

  Widget _buildImage(String path) {
    final image = path.startsWith('http')
        ? Image.network(path, fit: BoxFit.contain)
        : Image.asset(path, fit: BoxFit.contain);
    return Hero(tag: PhotoViewer.heroTag(path), child: image);
  }

  @override
  Widget build(BuildContext context) {
    final photos = widget.photos;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: _isZoomed
                ? const NeverScrollableScrollPhysics()
                : const PageScrollPhysics(),
            itemCount: photos.length,
            onPageChanged: (index) => setState(() {
              _zoomControllers[_index].value = Matrix4.identity();
              _index = index;
              _isZoomed = false;
            }),
            itemBuilder: (context, index) => GestureDetector(
              onDoubleTapDown: (details) =>
                  _doubleTapPosition = details.localPosition,
              onDoubleTap: _onDoubleTap,
              child: InteractiveViewer(
                transformationController: _zoomControllers[index],
                minScale: 1,
                maxScale: 4,
                onInteractionEnd: (_) => _updateZoomState(),
                child: Center(child: _buildImage(photos[index])),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.textOnDark,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (photos.length > 1)
                    Text(
                      '${_index + 1} / ${photos.length}',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textOnDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
