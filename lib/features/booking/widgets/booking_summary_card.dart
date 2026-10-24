import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/status_badge.dart';
import 'package:jol_go/data/models/booking.dart';

class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final trip = booking.trip;
    final seats = booking.seatNumbers;
    final seatsText = seats.length == 1 && seats.first == 1
        ? '№ 1, впереди'
        : '№ ${seats.join(', ')}';
    final dateText =
        '${Formatters.shortDate(trip.departureTime)}, '
        '${Formatters.time(trip.departureTime)}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${trip.from.name} → ${trip.to.name}',
                  style: AppTextStyles.h2.copyWith(fontSize: 18),
                ),
              ),
              StatusBadge(status: booking.status),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),

          _InfoRow(
            left: ('Дата и время', dateText),
            right: (seats.length == 1 ? 'Место' : 'Места', seatsText),
          ),
          _InfoRow(
            left: ('Машина', trip.car.model),
            right: ('Госномер', trip.car.plateNumber),
          ),
          _InfoRow(
            left: ('Посадка', trip.pickupPoint),
            right: ('К оплате водителю', Formatters.price(booking.totalPrice)),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.left, required this.right});

  final (String, String) left;
  final (String, String) right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _info(left)),
          const SizedBox(width: 12),
          Expanded(child: _info(right)),
        ],
      ),
    );
  }

  Widget _info((String, String) item) {
    final (label, value) = item;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
