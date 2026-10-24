import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/contact_launcher.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/avatar.dart';
import 'package:jol_go/core/widgets/primary_button.dart';
import 'package:jol_go/core/widgets/secondary_button.dart';
import 'package:jol_go/data/mock/mock_data.dart';
import 'package:jol_go/data/models/booking.dart';
import 'package:jol_go/features/booking/widgets/booking_summary_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key, required this.bookingId});

  final String bookingId;

  String _whatsAppMessage(Booking booking) {
    final trip = booking.trip;
    final seats = booking.seatNumbers.join(', ');
    return 'Здравствуйте, ${trip.driver.firstName}! '
        'Я забронировал место № $seats на поездку '
        '${trip.from.name} → ${trip.to.name}, '
        '${Formatters.shortDate(trip.departureTime)} в ${Formatters.time(trip.departureTime)}. '
        'Меня зовут ${mockUser.firstName}.';
  }

  Future<void> _openWhatsApp(BuildContext context, Booking booking) async {
    final opened = await ContactLauncher.whatsApp(
      booking.trip.driver.phone,
      message: _whatsAppMessage(booking),
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть WhatsApp')),
      );
    }
  }

  Future<void> _call(BuildContext context, String phone) async {
    final opened = await ContactLauncher.call(phone);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Не удалось начать звонок')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final booking = mockBookings.where((b) => b.id == bookingId).firstOrNull;

    if (booking == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Бронь не найдена')),
      );
    }

    final driver = booking.trip.driver;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.schedule, size: 40),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Заявка отправлена',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h1.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${driver.firstName} подтвердит бронь в ближайшее время. '
                      'Мы пришлём уведомление, когда место будет закреплено за вами.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    BookingSummaryCard(booking: booking),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Avatar(initials: driver.initials),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(driver.name, style: AppTextStyles.title),
                                const SizedBox(height: 2),
                                Text(
                                  driver.phone,
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _call(context, driver.phone),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.phone_outlined, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  PrimaryButton(
                    label: 'Написать в WhatsApp',
                    icon: const FaIcon(FontAwesomeIcons.whatsapp),
                    isDark: true,
                    onPressed: () => _openWhatsApp(context, booking),
                  ),
                  const SizedBox(height: 10),
                  SecondaryButton(
                    label: 'На главную',
                    onPressed: () => context.go('/search'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
