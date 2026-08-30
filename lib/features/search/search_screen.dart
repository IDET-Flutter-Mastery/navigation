import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/movie_card.dart';
import '../../core/widgets/todo_snackbar.dart';
import '../../data/movie_repository.dart';
import '../../models/movie.dart';

/// 👉 ADVANCED (optional): once you've covered query parameters,
/// this is a great screen to sync with `?q=` in the URL.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<Movie> _results = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() => _results = MovieRepository.instance.search(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                hintText: 'Search movies or genres…',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Expanded(
              child: _results.isEmpty
                  ? Center(
                      child: Text(
                        _controller.text.isEmpty
                            ? 'Start typing to search the catalog'
                            : 'No results for "${_controller.text}"',
                        style: AppTypography.bodyLarge
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: AppSizes.gridCrossAxisCount,
                        mainAxisSpacing: AppSpacing.xl,
                        crossAxisSpacing: AppSpacing.lg,
                        childAspectRatio: AppSizes.gridAspectRatio,
                      ),
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final movie = _results[index];
                        return MovieCard(
                          movie: movie,
                          width: double.infinity,
                          onTap: () => showTodoSnackbar(
                              context, 'Open "${movie.title}"'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
