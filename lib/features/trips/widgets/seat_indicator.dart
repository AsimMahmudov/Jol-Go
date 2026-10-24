import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';

class SeatIndicator extends StatelessWidget {
  const SeatIndicator({super.key, required this.taken, required this.total});

  final int total;
  final int taken;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++)
          Container(
            width: 14,
            height: 14,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: i < taken ? AppColors.seatTaken : AppColors.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: i < taken ? AppColors.seatTaken : AppColors.border,
                width: 1.5,
              ),
            ),
          ),
      ],
    );
  }
}
