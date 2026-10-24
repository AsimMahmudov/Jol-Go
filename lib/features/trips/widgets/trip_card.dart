import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/avatar.dart';
import 'package:jol_go/data/models/trip.dart';
import 'package:jol_go/features/trips/widgets/seat_indicator.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    super.key,
    required this.trip,
    required this.onTap,
    this.passengers = 1,
  });

  final Trip trip;
  final VoidCallback onTap;
  final int passengers;

  @override
  Widget build(BuildContext context) {
    final car = trip.car;
    final driver = trip.driver;
    final isAvailable = trip.freeSeats >= passengers;

    return Opacity(
      opacity: isAvailable ? 1 : 0.5,
      child: GestureDetector(
        onTap: isAvailable ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    Formatters.time(trip.departureTime),
                    style: AppTextStyles.h2.copyWith(fontSize: 24),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '~ ${trip.durationHours} ч',
                    style: AppTextStyles.caption,
                  ),
                  const Spacer(),
                  Text(
                    Formatters.price(trip.price),
                    style: AppTextStyles.h2.copyWith(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Avatar(initials: driver.initials),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${car.model} · ${car.color}',
                          style: AppTextStyles.title,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${driver.firstName} · ★ ${driver.rating}',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 12),

              Row(
                children: [
                  SeatIndicator(
                    total: car.seatCount,
                    taken: trip.takenSeats.length,
                  ),
                  const Spacer(),
                  Text(
                    trip.isFull
                        ? 'Мест нет'
                        : 'Свободно ${trip.freeSeats} из ${car.seatCount}',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
