import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/core/widgets/primary_button.dart';
import 'package:jol_go/data/models/city.dart';
import 'package:jol_go/data/models/trip_search.dart';
import 'package:jol_go/features/search/city_picker_screen.dart';
import 'package:jol_go/features/search/widgets/date_selector.dart';
import 'package:jol_go/features/search/widgets/passenger_counter.dart';
import 'package:jol_go/features/search/widgets/popular_routes.dart';
import 'package:jol_go/features/search/widgets/route_input_card.dart';
import 'package:jol_go/features/search/widgets/search_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _from = 'Бишкек';
  String _to = 'Талас';

  DateTime _date = DateUtils.dateOnly(DateTime.now());
  int _passengers = 1;

  void _swapCities() {
    setState(() {
      final temp = _from;
      _from = _to;
      _to = temp;
    });
  }

  Future<void> _pickCity({required bool isFrom}) async {
    final city = await context.push<City>(
      '/city-picker',
      extra: CityPickerArgs(
        title: isFrom ? 'Откуда едем?' : 'Куда едем?',
        takenLabel: isFrom ? 'Куда' : 'Откуда',
        selectedCity: isFrom ? _from : _to,
        takenCity: isFrom ? _to : _from,
      ),
    );

    if (city == null || !mounted) return;

    setState(() {
      if (isFrom) {
        _from = city.name;
      } else {
        _to = city.name;
      }
    });
  }

  void _search() {
    final search = TripSearch(
      from: _from,
      to: _to,
      date: _date,
      passengers: _passengers,
    );
    context.push(search.toLocation());
  }

  void _openPopularRoute(String city) {
    setState(() {
      _from = 'Бишкек';
      _to = city;
    });
    _search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 230,
              child: Container(color: AppColors.dark),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchHeader(userName: 'Асим'),
                    const SizedBox(height: 24),
                    _buildSearchCard(),
                    const SizedBox(height: 28),
                    PopularRoutes(onRouteTap: _openPopularRoute),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RouteInputCard(
            from: _from,
            to: _to,
            onFromTap: () => _pickCity(isFrom: true),
            onToTap: () => _pickCity(isFrom: false),
            onSwap: _swapCities,
          ),
          const SizedBox(height: 16),
          DateSelector(onChanged: (date) => _date = date),
          const SizedBox(height: 20),
          PassengerCounter(onChanged: (count) => _passengers = count),
          const SizedBox(height: 20),
          PrimaryButton(label: 'Найти поездки', onPressed: _search),
        ],
      ),
    );
  }
}
