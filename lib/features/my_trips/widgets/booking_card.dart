import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/avatar.dart';
import 'package:jol_go/core/widgets/status_badge.dart';
import 'package:jol_go/data/models/booking.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    required this.onDetails,
    this.onCancel,
  });

  final Booking booking;
  final VoidCallback onDetails;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final trip = booking.trip;
    final driver = trip.driver;
    final car = trip.car;
    final seats = booking.seatNumbers;
    final seatsText =
        '${seats.length == 1 ? 'место' : 'места'} ${seats.join(', ')}';

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
              Expanded(
                child: Text(
                  Formatters.tripDateTime(trip.departureTime),
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              StatusBadge(status: booking.status),
            ],
          ),
          const SizedBox(height: 14),

          _Stop(
            text: '${trip.from.name}, ${trip.pickupPoint}',
            isDestination: false,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Container(width: 2, height: 12, color: AppColors.border),
          ),
          _Stop(
            text: '${trip.to.name}, ${trip.dropoffPoint}',
            isDestination: true,
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
                Avatar(initials: driver.initials),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${driver.firstName} · ${car.model}',
                        style: AppTextStyles.title.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${car.plateNumber} · $seatsText',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  Formatters.price(booking.totalPrice),
                  style: AppTextStyles.title.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              GestureDetector(
                onTap: onDetails,
                child: Text(
                  'Подробнее о поездке',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(),
              if (onCancel != null)
                GestureDetector(
                  onTap: onCancel,
                  child: Text(
                    'Отменить бронь',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.danger,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stop extends StatelessWidget {
  const _Stop({required this.text, required this.isDestination});

  final String text;
  final bool isDestination;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDestination ? AppColors.primary : AppColors.surface,
            border: Border.all(color: AppColors.dark, width: 2.5),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
