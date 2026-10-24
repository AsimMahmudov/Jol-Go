import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';

class RouteInputCard extends StatelessWidget {
  const RouteInputCard({
    super.key,
    required this.from,
    required this.to,
    required this.onFromTap,
    required this.onToTap,
    required this.onSwap,
  });

  final String from;
  final String to;
  final VoidCallback onFromTap;
  final VoidCallback onToTap;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _CityField(
                label: 'Откуда',
                city: from,
                isDestination: false,
                onTap: onFromTap,
              ),
              const Divider(height: 1, indent: 30, color: AppColors.border),
              _CityField(
                label: 'Куда',
                city: to,
                isDestination: true,
                onTap: onToTap,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _SwapButton(onTap: onSwap),
      ],
    );
  }
}

class _CityField extends StatelessWidget {
  const _CityField({
    required this.label,
    required this.city,
    required this.isDestination,
    required this.onTap,
  });

  final String label;
  final String city;
  final bool isDestination;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDestination ? AppColors.primary : Colors.transparent,
                border: Border.all(color: AppColors.dark, width: 2.5),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Text(city, style: AppTextStyles.title.copyWith(fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SwapButton extends StatelessWidget {
  const _SwapButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: const Icon(Icons.swap_vert, size: 22),
      ),
    );
  }
}
