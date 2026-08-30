import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/actor_avatar.dart';
import '../../core/widgets/poster_box.dart';
import '../../core/widgets/rating_badge.dart';
import '../../core/widgets/todo_snackbar.dart';
import '../../data/movie_repository.dart';
import '../../models/actor.dart';

/// Movie details screen.
///
/// 👉 LIVE CODING 3: this screen currently takes [movieId] as a plain
/// constructor argument. Once you add the `/movie/:id` route, you'll
/// read this same id from `GoRouterState.pathParameters['id']` instead.
class DetailsScreen extends StatelessWidget {
  final String movieId;

  const DetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final movie = MovieRepository.instance.getMovieById(movieId);

    if (movie == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: const Center(child: Text('No movie with that id.')),
      );
    }

    final cast = MovieRepository.instance.getActorsByIds(movie.castIds);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: AppSizes.detailsHeaderHeight,
            pinned: true,
            backgroundColor: AppColors.surfaceElevated,
            flexibleSpace: FlexibleSpaceBar(
              background: PosterBox(
                colorSeed: movie.colorSeed,
                tmdbId: movie.tmdbId,
                kind: PosterImageKind.backdrop,
                borderRadius: 0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl, AppSpacing.xl, AppSpacing.xl, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: AppTypography.screenTitle),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'A Christopher Nolan Film',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    movie.tagline,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      RatingBadge(rating: movie.rating),
                      _Pill(text: movie.genre),
                      _Pill(text: '${movie.year}'),
                      _Pill(text: movie.durationLabel),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => showTodoSnackbar(context, 'Play'),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Play'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      OutlinedButton(
                        onPressed: () =>
                            showTodoSnackbar(context, 'Add to Favorites'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.secondary,
                          side: const BorderSide(color: AppColors.secondary),
                          minimumSize: const Size(
                            AppSizes.minTouchTarget,
                            AppSizes.minTouchTarget,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.favorite_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text('Overview', style: AppTypography.sectionTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    movie.description,
                    style: AppTypography.overview
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  if (cast.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xxl),
                    Text('Cast', style: AppTypography.sectionTitle),
                  ],
                ],
              ),
            ),
          ),
          if (cast.isNotEmpty)
            SliverToBoxAdapter(child: _CastRow(movieId: movie.id, cast: cast)),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxxl)),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: AppRadius.pillAll,
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        text,
        style: AppTypography.genre.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}

class _CastRow extends StatelessWidget {
  final String movieId;
  final List<Actor> cast;
  const _CastRow({required this.movieId, required this.cast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.castRowHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl, vertical: AppSpacing.md),
        itemCount: cast.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) {
          final actor = cast[index];
          return SizedBox(
            width: AppSizes.castItemWidth,
            child: GestureDetector(
              // 👉 LIVE CODING 4: this is the spot where a
              // showTodoSnackbar() placeholder gets swapped for a
              // real context.push() call to the nested actor route
              // declared in app_router.dart.
              onTap: () =>
                  context.push('/movie/$movieId/actor/${actor.actorId}'),
              child: Column(
                children: [
                  ActorAvatar(actor: actor, radius: AppSizes.castAvatarRadius),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    actor.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTypography.labelMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
