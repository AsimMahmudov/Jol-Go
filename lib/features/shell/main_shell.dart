import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _hasUnreadNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Поиск'),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Поездки',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _hasUnreadNotifications,
              smallSize: 9,
              backgroundColor: AppColors.seatTaken,
              child: Icon(Icons.notifications_none),
            ),
            label: 'Уведомления',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
