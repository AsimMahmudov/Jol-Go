import 'package:go_router/go_router.dart';
import 'package:jol_go/features/booking/booking_success_screen.dart';
import 'package:jol_go/features/my_trips/my_trips_screen.dart';
import 'package:jol_go/features/notifications/notifications_screen.dart';
import 'package:jol_go/features/profile/edit_profile_screen.dart';
import 'package:jol_go/features/profile/profile_screen.dart';
import 'package:jol_go/features/search/city_picker_screen.dart';
import 'package:jol_go/features/search/search_screen.dart';
import 'package:jol_go/features/shell/main_shell.dart';
import 'package:jol_go/features/trip_details/trip_details_screen.dart';
import 'package:jol_go/features/trips/trip_list_screen.dart';
import 'package:jol_go/data/models/trip_search.dart';

final router = GoRouter(
  initialLocation: '/search',
  routes: [
    // Экраны с нижней навигацией
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my-trips',
              builder: (context, state) => const MyTripsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notifications',
              builder: (context, state) => const NotificationsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),

    // Экраны поверх, без нижней навигации
    GoRoute(
      path: '/city-picker',
      builder: (context, state) =>
          CityPickerScreen(args: state.extra! as CityPickerArgs),
    ),
    GoRoute(
      path: '/trips',
      builder: (context, state) => TripListScreen(
        search: TripSearch.fromQuery(state.uri.queryParameters),
      ),
    ),
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => EditProfileScreen(),
    ),
    GoRoute(
      path: '/trips/:id',
      builder: (context, state) => TripDetailsScreen(
        tripId: state.pathParameters['id']!,
        maxSeats: int.tryParse(state.uri.queryParameters['pax'] ?? '') ?? 1,
      ),
    ),
    GoRoute(
      path: '/booking/:id/success',
      builder: (context, state) =>
          BookingSuccessScreen(bookingId: state.pathParameters['id']!),
    ),
  ],
);
