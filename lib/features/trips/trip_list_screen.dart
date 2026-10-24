import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/back_button.dart';
import 'package:jol_go/data/mock/mock_data.dart';
import 'package:jol_go/data/models/trip.dart';
import 'package:jol_go/data/models/trip_search.dart';
import 'package:jol_go/features/trips/widgets/trip_card.dart';
import 'package:jol_go/features/trips/widgets/trip_filters.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({super.key, required this.search});

  final TripSearch search;

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  TripFilter _filter = TripFilter.all;

  List<Trip> get _trips {
    final search = widget.search;

    final result = mockTrips
        .where(
          (trip) =>
              trip.from.name == search.from &&
              trip.to.name == search.to &&
              DateUtils.isSameDay(trip.departureTime, search.date),
        )
        .toList();

    switch (_filter) {
      case TripFilter.all:
        break;
      case TripFilter.earliest:
        result.sort((a, b) => a.departureTime.compareTo(b.departureTime));
      case TripFilter.cheapest:
        result.sort((a, b) => a.price.compareTo(b.price));
      case TripFilter.minivan:
        result.retainWhere((trip) => trip.car.isMinivan);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final trips = _trips;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(child: trips.isEmpty ? _buildEmpty() : _buildList(trips)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final search = widget.search;
    final passengersWord = Formatters.plural(
      search.passengers,
      'пассажир',
      'пассажира',
      'пассажиров',
    );

    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AppBackButton(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${search.from} → ${search.to}',
                      style: AppTextStyles.h2,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${Formatters.relativeDate(search.date)} · '
                      '${search.passengers} $passengersWord',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TripFilters(
            selected: _filter,
            onChanged: (filter) => setState(() => _filter = filter),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Trip> trips) {
    final foundWord = Formatters.plural(
      trips.length,
      'поездка',
      'поездки',
      'поездок',
    );

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text(
            'Найдено ${trips.length} $foundWord',
            style: AppTextStyles.caption,
          );
        }

        final trip = trips[index - 1];
        return TripCard(
          trip: trip,
          passengers: widget.search.passengers,
          onTap: () =>
              context.push('/trips/${trip.id}?pax=${widget.search.passengers}'),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.directions_car_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 12),
            Text('Поездок не найдено', style: AppTextStyles.title),
            SizedBox(height: 4),
            Text(
              'Попробуйте другую дату или фильтр',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
