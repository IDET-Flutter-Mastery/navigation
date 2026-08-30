import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/movie_card.dart';
import '../../core/widgets/poster_box.dart';
import '../../core/widgets/rating_badge.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/todo_snackbar.dart';
import '../../data/movie_repository.dart';
import '../../models/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = MovieRepository.instance;
    final trending = repo.getByCategory(MovieCategory.trending);
    final topRated = repo.getByCategory(MovieCategory.topRated);
    final newReleases = repo.getByCategory(MovieCategory.newRelease);
    final featured = trending.first;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _AppBarRow(
                  onIconTap: (label) => showTodoSnackbar(context, label)),
            ),
            SliverToBoxAdapter(child: _FeaturedBanner(movie: featured)),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Trending Now',
                onSeeAll: () => context.go(AppConstants.routeMovies),
              ),
            ),
            SliverToBoxAdapter(child: _MovieRow(movies: trending)),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Top Rated',
                onSeeAll: () => context.go(AppConstants.routeMovies),
              ),
            ),
            SliverToBoxAdapter(child: _MovieRow(movies: topRated)),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'New Releases',
                onSeeAll: () => context.go(AppConstants.routeMovies),
              ),
            ),
            SliverToBoxAdapter(child: _MovieRow(movies: newReleases)),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
          ],
        ),
      ),
      // bottomNavigationBar: _HomeBottomNav(
      //   onTap: (label) => showTodoSnackbar(context, label),
      // ),
    );
  }
}

class _AppBarRow extends StatelessWidget {
  final void Function(String label) onIconTap;
  const _AppBarRow({required this.onIconTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl, AppSpacing.lg, AppSpacing.md, AppSpacing.xs),
      child: Row(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: AppColors.heroGradient,
            ).createShader(bounds),
            child: const Icon(Icons.theaters_rounded,
                color: Colors.white, size: AppSizes.iconXl),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(AppConstants.appName, style: AppTypography.appLogo),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search_rounded),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.surfaceElevated,
              shape: const CircleBorder(),
            ),
            onPressed: () => onIconTap('Search'),
          ),
        ],
      ),
    );
  }
}

class _FeaturedBanner extends StatelessWidget {
  final Movie movie;
  const _FeaturedBanner({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.sm),
      child: AspectRatio(
        aspectRatio: AppSizes.bannerAspectRatio,
        child: PosterBox(
          colorSeed: movie.colorSeed,
          tmdbId: movie.tmdbId,
          kind: PosterImageKind.backdrop,
          borderRadius: AppRadius.xxl,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RatingBadge(rating: movie.rating),
                const SizedBox(height: AppSpacing.md),
                Text(
                  movie.title,
                  style:
                      AppTypography.screenTitle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  movie.tagline,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () =>
                          showTodoSnackbar(context, 'View Details'),
                      icon: const Icon(Icons.info_outline_rounded,
                          size: AppSizes.iconSm),
                      label: const Text('Details'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () =>
                          showTodoSnackbar(context, 'Play Trailer'),
                      icon: const Icon(Icons.play_arrow_rounded,
                          size: AppSizes.iconSm),
                      label: const Text('Trailer'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MovieRow extends StatelessWidget {
  final List<Movie> movies;
  const _MovieRow({required this.movies});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.movieRowHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(
            movie: movie,
            onTap: () => context.push('/movie/${movie.id}'),
          );
        },
      ),
    );
  }
}

// class _HomeBottomNav extends StatelessWidget {
//   final void Function(String label) onTap;
//   const _HomeBottomNav({required this.onTap});

//   // 👉 LIVE CODING 5: this bar only exists on HomeScreen right now —
//   // notice it disappears the moment you navigate to another screen.
//   // That's the exact problem ShellRoute solves. Once wired, this
//   // whole widget gets replaced by core/widgets/app_shell.dart.
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: 0,
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             context.go('/');
//             break;
//           case 1:
//             context.go('/favorites');
//             break;
//           case 2:
//             context.go('/settings');
//             break;
//         }
//       },
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.settings_rounded), label: 'Settings'),
//       ],
//     );
//   }
// }
