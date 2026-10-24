import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/widgets/primary_button.dart';
import 'package:jol_go/data/mock/mock_data.dart';
import 'package:jol_go/data/models/booking.dart';
import 'package:jol_go/features/my_trips/widgets/booking_card.dart';
import 'package:jol_go/features/my_trips/widgets/segmented_tabs.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  int _tab = 0;

  List<Booking> get _upcoming =>
      mockBookings.where((b) => b.isUpcoming).toList()
        ..sort((a, b) => a.trip.departureTime.compareTo(b.trip.departureTime));

  List<Booking> get _past =>
      mockBookings.where((b) => !b.isUpcoming).toList()
        ..sort((a, b) => b.trip.departureTime.compareTo(a.trip.departureTime));

  Future<void> _cancel(Booking booking) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Отменить бронь?'),
        content: const Text(
          'Водитель получит уведомление, а место снова станет свободным.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            style: TextButton.styleFrom(foregroundColor: AppColors.dark),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Отменить'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final index = mockBookings.indexOf(booking);
    setState(() {
      mockBookings[index] = booking.copyWith(status: BookingStatus.cancelled);
    });
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = _upcoming;
    final items = _tab == 0 ? upcoming : _past;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Мои поездки', style: AppTextStyles.h1),
                  const SizedBox(height: 16),
                  SegmentedTabs(
                    labels: ['Предстоящие · ${upcoming.length}', 'Прошедшие'],
                    selectedIndex: _tab,
                    onChanged: (index) => setState(() => _tab = index),
                  ),
                ],
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final booking = items[index];
                        return BookingCard(
                          booking: booking,
                          onDetails: () =>
                              context.push('/booking/${booking.id}/success'),
                          onCancel: booking.isUpcoming
                              ? () => _cancel(booking)
                              : null,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    final isUpcomingTab = _tab == 0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 12),
            Text(
              isUpcomingTab
                  ? 'Нет предстоящих поездок'
                  : 'Прошедших поездок пока нет',
              style: AppTextStyles.title,
            ),
            if (isUpcomingTab) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  label: 'Найти поездку',
                  onPressed: () => context.go('/search'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
