import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/contact_launcher.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/avatar.dart';
import 'package:jol_go/data/models/trip.dart';
import 'package:jol_go/features/trip_details/widgets/contact_buttons.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final driver = trip.driver;
    final car = trip.car;
    final color = '${car.color[0].toUpperCase()}${car.color.substring(1)}';
    final seatsText =
        '${car.seatCount} ${Formatters.plural(car.seatCount, 'пассажирское место', 'пассажирских места', 'пассажирских мест')}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(initials: driver.initials, size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driver.name,
                      style: AppTextStyles.h2.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '★ ${driver.rating} · водитель',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(car.model, style: AppTextStyles.title),
                      const SizedBox(height: 2),
                      Text('$color · $seatsText', style: AppTextStyles.caption),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.dark, width: 2),
                  ),
                  child: Text(
                    car.plateNumber,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          ContactButtons(
            onCall: () => ContactLauncher.call(driver.phone),
            onWhatsApp: () => ContactLauncher.whatsApp(driver.phone),
          ),
        ],
      ),
    );
  }
}
