import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/features/trip_details/widgets/seat_tile.dart';

class _CarLayout {
  const _CarLayout({
    required this.image,
    required this.aspectRatio,
    required this.seats,
  });

  final String image;
  final double aspectRatio;
  final Map<int, Offset> seats;
}

const _sedan = _CarLayout(
  image: 'assets/images/car-5-pos.png',
  aspectRatio: 408 / 612,
  seats: {
    1: Offset(0.65, 0.385),
    2: Offset(0.34, 0.63),
    3: Offset(0.50, 0.63),
    4: Offset(0.66, 0.63),
  },
);

const _minivan = _CarLayout(
  image: 'assets/images/car-8-pos.png',
  aspectRatio: 408 / 612,
  seats: {
    1: Offset(0.65, 0.345),
    2: Offset(0.34, 0.53),
    3: Offset(0.50, 0.53),
    4: Offset(0.66, 0.53),
    5: Offset(0.34, 0.725),
    6: Offset(0.50, 0.725),
    7: Offset(0.66, 0.725),
  },
);

class SeatMap extends StatelessWidget {
  const SeatMap({
    super.key,
    required this.seatCount,
    required this.takenSeats,
    required this.selectedSeats,
    required this.onSeatTap,
  });

  final int seatCount;
  final List<int> takenSeats;
  final Set<int> selectedSeats;
  final ValueChanged<int> onSeatTap;

  static const _imageWidth = 260.0;
  static const _tileSize = 38.0;

  _CarLayout? get _carLayout => switch (seatCount) {
    <= 4 => _sedan,
    <= 7 => _minivan,
    _ => null,
  };

  SeatState _stateOf(int seat) {
    if (selectedSeats.contains(seat)) return SeatState.selected;
    if (takenSeats.contains(seat)) return SeatState.taken;
    return SeatState.free;
  }

  Widget _buildSeat(int seat, {double size = SeatTile.defaultSize}) {
    final state = _stateOf(seat);
    return SeatTile(
      state: state,
      number: seat,
      size: size,
      onTap: state == SeatState.taken ? null : () => onSeatTap(seat),
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = _carLayout;
    if (layout == null) return _buildSchematic();

    return SizedBox(
      width: _imageWidth,
      child: AspectRatio(
        aspectRatio: layout.aspectRatio,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    layout.image,
                    errorBuilder: (context, error, stackTrace) =>
                        const ColoredBox(color: AppColors.background),
                  ),
                ),
                for (final MapEntry(key: seat, value: position)
                    in layout.seats.entries)
                  if (seat <= seatCount)
                    Positioned(
                      left: position.dx * width - _tileSize / 2,
                      top: position.dy * height - _tileSize / 2,
                      child: _buildSeat(seat, size: _tileSize),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSchematic() {
    const gap = 16.0;
    const padding = 20.0;
    const size = SeatTile.defaultSize;

    final rows = <List<int?>>[
      [0, null, 1],
      for (var first = 2; first <= seatCount; first += 3)
        [for (var s = first; s < first + 3; s++) s <= seatCount ? s : null],
    ];

    return Container(
      width: size * 3 + gap * 2 + padding * 2 + 6,
      padding: const EdgeInsets.fromLTRB(padding, 16, padding, 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: AppColors.border, width: 3),
      ),
      child: Column(
        children: [
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: gap),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final seat in row)
                    switch (seat) {
                      null => const SizedBox(width: size, height: size),
                      0 => const SeatTile(state: SeatState.driver),
                      _ => _buildSeat(seat),
                    },
                ],
              ),
            ),
        ],
      ),
    );
  }
}
