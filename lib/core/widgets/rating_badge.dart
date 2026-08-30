import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// A pill-shaped rating badge — gold star + score, per the
/// "Rating Star" spec color, on a translucent dark chip so it reads
/// cleanly over any poster or photo.
class RatingBadge extends StatelessWidget {
  final double rating;
  final bool compact;

  const RatingBadge({super.key, required this.rating, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.xs : AppSpacing.sm,
        vertical: AppSpacing.xs / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: AppColors.ratingStar.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: AppColors.ratingStar,
            size: compact ? AppSpacing.md : AppSpacing.lg,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            rating.toStringAsFixed(1),
            style: (compact ? AppTypography.labelSmall : AppTypography.rating)
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
