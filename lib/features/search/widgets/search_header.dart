import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jol_go/app/theme/app_colors.dart';
import 'package:jol_go/app/theme/app_text_styles.dart';
import 'package:jol_go/core/widgets/avatar.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Салам, $userName',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textOnDark.withValues(alpha: 0.8),
                ),
              ),
            ),
            Avatar(
              initials: userName[0],
              onTap: () => context.go('/profile'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Куда едем?',
          style: AppTextStyles.h1.copyWith(color: AppColors.textOnDark),
        ),
      ],
    );
  }
}
