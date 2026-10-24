import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/back_button.dart';
import 'package:jol_go/data/mock/mock_data.dart';
import 'package:jol_go/data/models/booking.dart';
import 'package:jol_go/data/models/trip.dart';
import 'package:jol_go/features/trip_details/widgets/booking_bottom_bar.dart';
import 'package:jol_go/features/trip_details/widgets/car_gallery.dart';
import 'package:jol_go/features/trip_details/widgets/driver_card.dart';
import 'package:jol_go/features/trip_details/widgets/route_timeline.dart';
import 'package:jol_go/features/trip_details/widgets/seat_map.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({
    super.key,
    required this.tripId,
    required this.maxSeats,
  });

  final String tripId;
  final int maxSeats;

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  static const _photoHeight = 240.0;

  final Set<int> _selectedSeats = {};

  Trip? get _trip => mockTrips.where((t) => t.id == widget.tripId).firstOrNull;

  void _toggleSeat(int seat) {
    if (_selectedSeats.contains(seat)) {
      setState(() => _selectedSeats.remove(seat));
      return;
    }
    if (_selectedSeats.length < widget.maxSeats) {
      setState(() => _selectedSeats.add(seat));
      return;
    }
    if (widget.maxSeats == 1) {
      setState(
        () => _selectedSeats
          ..clear()
          ..add(seat),
      );
      return;
    }
    final word = Formatters.plural(widget.maxSeats, 'места', 'мест', 'мест');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Можно выбрать не больше ${widget.maxSeats} $word'),
      ),
    );
  }

  void _book(Trip trip) {
    final booking = Booking(
      id: 'b${DateTime.now().millisecondsSinceEpoch}',
      trip: trip,
      seatNumbers: _selectedSeats.toList()..sort(),
      status: BookingStatus.pending,
    );
    mockBookings.insert(0, booking);
    context.pushReplacement('/booking/${booking.id}/success');
  }

  @override
  Widget build(BuildContext context) {
    final trip = _trip;

    if (trip == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Поездка не найдена')),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  CarGallery(
                    height: _photoHeight,
                    photos: trip.car.photos,
                    bottomInset: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      _photoHeight - 32,
                      16,
                      16,
                    ),
                    child: Column(
                      children: [
                        DriverCard(trip: trip),
                        const SizedBox(height: 12),
                        _buildCard(child: RouteTimeline(trip: trip)),
                        const SizedBox(height: 12),
                        _buildCard(child: _buildSeatsSection(trip)),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    left: 16,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: AppBackButton(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BookingBottomBar(
            seats: _selectedSeats.toList()..sort(),
            pricePerSeat: trip.price,
            onBook: _selectedSeats.isEmpty ? null : () => _book(trip),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildSeatsSection(Trip trip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Выберите места',
              style: AppTextStyles.h2.copyWith(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildLegend(),
        const SizedBox(height: 20),
        Center(
          child: SeatMap(
            seatCount: trip.car.seatCount,
            takenSeats: trip.takenSeats,
            selectedSeats: _selectedSeats,
            onSeatTap: _toggleSeat,
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'Нажмите на свободное место, чтобы выбрать',
            style: AppTextStyles.caption,
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(AppColors.surface, AppColors.border, 'Свободно'),
        const SizedBox(width: 16),
        _legendItem(AppColors.seatTaken, AppColors.seatTaken, 'Занято'),
        const SizedBox(width: 16),
        _legendItem(AppColors.primary, AppColors.dark, 'Ваше'),
      ],
    );
  }

  Widget _legendItem(Color fill, Color border, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: border, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}
