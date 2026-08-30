import 'package:flutter/material.dart';
import '../../models/movie.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'poster_box.dart';
import 'rating_badge.dart';

/// A polished movie poster card.
///
/// [onTap] is intentionally left for you to wire up during the
/// live coding sessions — that's where `context.push()` will go!
class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final double width;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.width = AppSizes.movieCardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        borderRadius: AppRadius.lgAll,
        onTap: onTap,
        splashColor: AppColors.primary.withValues(alpha: 0.12),
        highlightColor: AppColors.primary.withValues(alpha: 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: AppSizes.posterAspectRatio,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppRadius.lgAll,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gradientFor(movie.colorSeed)
                          .last
                          .withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: PosterBox(
                  colorSeed: movie.colorSeed,
                  tmdbId: movie.tmdbId,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: RatingBadge(rating: movie.rating, compact: true),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.movieTitle.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs / 2),
            Text(
              '${movie.genre} · ${movie.year}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTypography.genre.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
