import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';

class PopularRoutes extends StatelessWidget {
  const PopularRoutes({super.key, required this.onRouteTap});

  final ValueChanged<String> onRouteTap;

  static const _routes = [
    (city: 'Ош', hours: 10),
    (city: 'Каракол', hours: 6),
    (city: 'Нарын', hours: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Популярные направления', style: AppTextStyles.h2),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              for (var i = 0; i < _routes.length; i++) ...[
                if (i > 0)
                  const Divider(height: 1, indent: 72, color: AppColors.border),
                _RouteTile(
                  city: _routes[i].city,
                  hours: _routes[i].hours,
                  onTap: () => onRouteTap(_routes[i].city),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RouteTile extends StatelessWidget {
  const _RouteTile({
    required this.city,
    required this.hours,
    required this.onTap,
  });

  final String city;
  final int hours;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.directions_car_outlined, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Бишкек → $city', style: AppTextStyles.title),
                  const SizedBox(height: 2),
                  Text('в пути ~ $hours ч', style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
