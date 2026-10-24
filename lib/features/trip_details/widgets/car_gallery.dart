import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/widgets/photo_viewer.dart';

class CarGallery extends StatefulWidget {
  const CarGallery({
    super.key,
    required this.height,
    required this.photos,
    this.bottomInset = 0,
  });

  static const maxPhotos = 4;

  final double height;
  final List<String> photos;
  final double bottomInset;

  @override
  State<CarGallery> createState() => _CarGalleryState();
}

class _CarGalleryState extends State<CarGallery> {
  int _index = 0;

  List<String> get _photos => widget.photos.take(CarGallery.maxPhotos).toList();

  @override
  Widget build(BuildContext context) {
    final photos = _photos;

    return SizedBox(
      height: widget.height,
      child: ColoredBox(
        color: AppColors.dark,
        child: photos.isEmpty
            ? _buildPlaceholder()
            : Stack(
                fit: StackFit.expand,
                children: [
                  PageView.builder(
                    itemCount: photos.length,
                    onPageChanged: (index) => setState(() => _index = index),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => PhotoViewer.open(
                        context,
                        photos: photos,
                        initialIndex: index,
                      ),
                      child: Hero(
                        tag: PhotoViewer.heroTag(photos[index]),
                        child: _buildPhoto(photos[index]),
                      ),
                    ),
                  ),
                  if (photos.length > 1)
                    Positioned(
                      right: 16,
                      bottom: widget.bottomInset + 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_index + 1} / ${photos.length}',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textOnDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildPhoto(String path) {
    Widget errorBuilder(
      BuildContext context,
      Object error,
      StackTrace? stack,
    ) => _buildPlaceholder();

    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : const Center(
                child: CircularProgressIndicator(color: AppColors.textOnDark),
              ),
        errorBuilder: errorBuilder,
      );
    }

    return Image.asset(path, fit: BoxFit.cover, errorBuilder: errorBuilder);
  }

  Widget _buildPlaceholder() {
    final faded = AppColors.textOnDark.withValues(alpha: 0.4);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.directions_car_outlined, size: 96, color: faded),
          const SizedBox(height: 8),
          Text(
            'Фото машины',
            style: AppTextStyles.caption.copyWith(color: faded),
          ),
        ],
      ),
    );
  }
}
