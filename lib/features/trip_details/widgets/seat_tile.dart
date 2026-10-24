import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';

enum SeatState { free, taken, selected, driver }

class SeatTile extends StatelessWidget {
  const SeatTile({
    super.key,
    required this.state,
    this.number,
    this.onTap,
    this.size = defaultSize,
  });

  static const defaultSize = 52.0;

  final SeatState state;
  final int? number;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final (background, border, foreground) = switch (state) {
      SeatState.free => (
        AppColors.surface,
        AppColors.border,
        AppColors.textPrimary,
      ),
      SeatState.taken => (
        AppColors.seatTaken,
        AppColors.seatTaken,
        AppColors.textOnDark,
      ),
      SeatState.selected => (
        AppColors.primary,
        AppColors.dark,
        AppColors.textPrimary,
      ),
      SeatState.driver => (
        AppColors.border,
        AppColors.border,
        AppColors.textSecondary,
      ),
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(size * 0.25),
          border: Border.all(color: border, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: state == SeatState.driver
            ? Icon(Icons.trip_origin, color: foreground)
            : Text(
                '$number',
                style: AppTextStyles.title.copyWith(color: foreground),
              ),
      ),
    );
  }
}
