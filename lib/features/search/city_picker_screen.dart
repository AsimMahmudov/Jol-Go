import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/data/mock/mock_data.dart';
import 'package:jol_go/data/models/city.dart';
import 'package:jol_go/features/search/widgets/city_list_item.dart';

class CityPickerArgs {
  const CityPickerArgs({
    required this.title,
    required this.takenLabel,
    this.selectedCity,
    this.takenCity,
  });

  final String title;
  final String takenLabel;
  final String? selectedCity;
  final String? takenCity;
}

class CityPickerScreen extends StatefulWidget {
  const CityPickerScreen({super.key, required this.args});

  final CityPickerArgs args;

  @override
  State<CityPickerScreen> createState() => _CityPickerScreenState();
}

class _CityPickerScreenState extends State<CityPickerScreen> {
  String _query = '';

  List<City> get _filteredCities {
    final query = _query.trim().toLowerCase();
    return mockCities
        .where((city) => city.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final cities = _filteredCities;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (cities.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'Ничего не найдено',
                    style: AppTextStyles.caption,
                  ),
                ),
              )
            else ...[
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text('Города Кыргызстана', style: AppTextStyles.caption),
              ),
              Expanded(child: _buildList(cities)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.close, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Text(widget.args.title, style: AppTextStyles.h2),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            autofocus: true,
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: 'Город или село',
              hintStyle: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<City> cities) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        final isFirst = index == 0;
        final isLast = index == cities.length - 1;
        final isTaken = city.name == widget.args.takenCity;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(isFirst ? 16 : 0),
              bottom: Radius.circular(isLast ? 16 : 0),
            ),
          ),
          child: Column(
            children: [
              CityListItem(
                city: city,
                isSelected: city.name == widget.args.selectedCity,
                hint: isTaken
                    ? 'Уже выбран как «${widget.args.takenLabel}»'
                    : null,
                onTap: isTaken ? null : () => context.pop(city),
              ),
              if (!isLast)
                const Divider(height: 1, indent: 16, color: AppColors.border),
            ],
          ),
        );
      },
    );
  }
}
