import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/movie_card.dart';
import '../../data/movie_repository.dart';

/// Full catalog screen.
///
/// 👉 LIVE CODING 2: this is the screen you'll navigate to with
/// `context.go('/movies')`.
class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = MovieRepository.instance.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('All Movies')),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.xxl),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppSizes.gridCrossAxisCount,
          mainAxisSpacing: AppSpacing.xl,
          crossAxisSpacing: AppSpacing.lg,
          childAspectRatio: AppSizes.gridAspectRatio,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(
            movie: movie,
            width: double.infinity,
            onTap: () => context.push('/movie/${movie.id}'),
          );
        },
      ),
    );
  }
}
