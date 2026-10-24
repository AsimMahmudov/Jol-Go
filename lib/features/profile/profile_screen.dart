import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/data/mock/mock_data.dart';
import 'package:jol_go/features/profile/widgets/profile_header.dart';
import 'package:jol_go/features/profile/widgets/profile_menu_item.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/data/models/booking.dart';
import 'package:jol_go/features/profile/widgets/upcoming_trip_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  Future<void> _confirm({
    required String title,
    required String message,
    required String actionLabel,
    required VoidCallback onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(actionLabel),
          ),
        ],
      ),
    );

    if (confirmed == true) onConfirm();
  }

  @override
  Widget build(BuildContext context) {
    final booking = mockBookings
        .where((b) => b.status != BookingStatus.cancelled)
        .firstOrNull;
    const chevron = Icon(Icons.chevron_right, color: AppColors.textSecondary);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: booking == null ? 0 : 56,
                  child: const ColoredBox(color: AppColors.dark),
                ),
                Column(
                  children: [
                    ProfileHeader(
                      user: mockUser,
                      onEditTap: () => context.push('profile/edit'),
                    ),
                    if (booking != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: UpcomingTripCard(
                          booking: booking,
                          onTap: () =>
                              context.push('/booking/${booking.id}/success'),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.notifications_none,
                        title: 'Уведомления',
                        onTap: () => setState(
                          () => _notificationsEnabled = !_notificationsEnabled,
                        ),
                        trailing: Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) =>
                              setState(() => _notificationsEnabled = value),
                          activeThumbColor: AppColors.primary,
                          activeTrackColor: AppColors.dark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.help_outline,
                        title: 'Поддержка',
                        trailing: chevron,
                        onTap: () => debugPrint('Поддержка'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.shield_outlined,
                        title: 'Политика конфиденциальности',
                        trailing: chevron,
                        onTap: () => debugPrint('Политика'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.logout,
                        title: 'Выйти',
                        isBold: true,
                        onTap: () => _confirm(
                          title: 'Выйти из аккаунта?',
                          message:
                              'Чтобы снова войти, понадобится номер телефона.',
                          actionLabel: 'Выйти',
                          onConfirm: () => debugPrint('Выход'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => _confirm(
                      title: 'Удалить аккаунт?',
                      message:
                          'Все данные и история поездок будут удалены. '
                          'Это действие нельзя отменить.',
                      actionLabel: 'Удалить',
                      onConfirm: () => debugPrint('Удаление аккаунта'),
                    ),
                    child: Text(
                      'Удалить аккаунт',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
