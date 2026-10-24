import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/data/models/city.dart';

class CityListItem extends StatelessWidget {
  const CityListItem({
    super.key,
    required this.city,
    required this.onTap,
    this.isSelected = false,
    this.hint,
  });

  final City city;
  final VoidCallback? onTap;
  final bool isSelected;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.name,
                    style: AppTextStyles.title.copyWith(
                      color: isDisabled ? AppColors.textSecondary : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(hint ?? city.region, style: AppTextStyles.caption),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}
