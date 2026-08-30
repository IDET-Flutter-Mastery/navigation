import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSizes.iconHero + AppSpacing.xxl,
              height: AppSizes.iconHero + AppSpacing.xxl,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceElevated,
                border: Border.fromBorderSide(
                  BorderSide(color: AppColors.divider),
                ),
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: AppSizes.iconHero * 0.55,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('No favorites yet', style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Movies you love will show up here.',
              style: AppTypography.bodyLarge
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
