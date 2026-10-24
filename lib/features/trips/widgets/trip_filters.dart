import 'package:flutter/material.dart';
import 'package:jol_go/core/widgets/app_chip.dart';

enum TripFilter {
  all('Все'),
  earliest('Раньше'),
  cheapest('Дешевле'),
  minivan('Минивэн');

  const TripFilter(this.label);

  final String label;
}

class TripFilters extends StatelessWidget {
  const TripFilters({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final TripFilter selected;
  final ValueChanged<TripFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in TripFilter.values)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: AppChip(
                label: filter.label,
                isSelected: filter == selected,
                onTap: () => onChanged(filter),
              ),
            ),
        ],
      ),
    );
  }
}
