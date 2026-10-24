import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/data/models/trip.dart';

class RouteTimeline extends StatelessWidget {
  const RouteTimeline({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              const SizedBox(width: 14),
              const _Dot(isDestination: false),
              Expanded(child: Container(width: 2, color: AppColors.border)),
              const _Dot(isDestination: true),
              const SizedBox(height: 22),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              children: [
                _Stop(
                  city: trip.from.name,
                  place: trip.pickupPoint,
                  time: Formatters.time(trip.departureTime),
                ),
                const SizedBox(height: 20),
                _Stop(
                  city: trip.to.name,
                  place: trip.dropoffPoint,
                  time: '~${Formatters.time(trip.arrivalTime)}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stop extends StatelessWidget {
  const _Stop({required this.city, required this.place, required this.time});

  final String city;
  final String place;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(city, style: AppTextStyles.title),
              const SizedBox(height: 2),
              Text(place, style: AppTextStyles.caption),
            ],
          ),
        ),
        Text(
          time,
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.isDestination});

  final bool isDestination;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDestination ? AppColors.primary : AppColors.surface,
        border: Border.all(color: AppColors.dark, width: 2.5),
      ),
    );
  }
}
