import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';
import 'package:jol_go/core/widgets/app_chip.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key, required this.onChanged});

  final ValueChanged<DateTime> onChanged;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int _selectedIndex = 0;
  late final List<DateTime> _dates;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _dates = List.generate(3, (i) => today.add(Duration(days: i)));
  }

  String _label(int index) {
    final date = _dates[index];
    if (index == 0) return 'Сегодня, ${Formatters.shortDate(date)}';
    if (index == 1) return 'Завтра';
    return Formatters.weekdayDay(date);
  }

  void _select(int index) {
    setState(() => _selectedIndex = index);
    widget.onChanged(_dates[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Когда', style: AppTextStyles.caption),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < _dates.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                AppChip(
                  label: _label(i),
                  isSelected: i == _selectedIndex,
                  onTap: () => _select(i),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
