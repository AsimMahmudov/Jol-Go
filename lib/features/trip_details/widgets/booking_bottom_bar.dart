import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/primary_button.dart';

class BookingBottomBar extends StatelessWidget {
  const BookingBottomBar({
    super.key,
    required this.seats,
    required this.pricePerSeat,
    required this.onBook,
  });

  final List<int> seats;
  final int pricePerSeat;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    final seatsWord = Formatters.plural(seats.length, 'место', 'места', 'мест');
    final caption = seats.isEmpty
        ? 'Место не выбрано'
        : '${seats.length} $seatsWord: № ${seats.join(', ')}';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(caption, style: AppTextStyles.caption),
                    const SizedBox(height: 2),
                    Text(
                      Formatters.price(pricePerSeat * seats.length),
                      style: AppTextStyles.h2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 170,
                child: PrimaryButton(label: 'Забронировать', onPressed: onBook),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
