import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/utils/formatters.dart';

class PassengerCounter extends StatefulWidget {
  const PassengerCounter({
    super.key,
    required this.onChanged,
    this.min = 1,
    this.max = 4,
  });

  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  State<PassengerCounter> createState() => _PassengerCounterState();
}

class _PassengerCounterState extends State<PassengerCounter> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.min;
  }

  void _change(int delta) {
    setState(() => _count += delta);
    widget.onChanged(_count);
  }

  @override
  Widget build(BuildContext context) {
    final word = Formatters.plural(
      _count,
      'пассажир',
      'пассажира',
      'пассажиров',
    );

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Пассажиры', style: AppTextStyles.caption),
              const SizedBox(height: 4),
              Text('$_count $word', style: AppTextStyles.title),
            ],
          ),
        ),
        _CounterButton(
          icon: Icons.remove,
          onTap: _count > widget.min ? () => _change(-1) : null,
        ),
        SizedBox(
          width: 40,
          child: Text(
            '$_count',
            textAlign: TextAlign.center,
            style: AppTextStyles.title,
          ),
        ),
        _CounterButton(
          icon: Icons.add,
          onTap: _count < widget.max ? () => _change(1) : null,
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isEnabled ? AppColors.textPrimary : AppColors.border,
        ),
      ),
    );
  }
}
