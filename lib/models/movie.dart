enum MovieCategory { trending, topRated, newRelease }

class Movie {
  final String id;
  final String title;
  final String tagline;
  final String genre;
  final int year;
  final int durationMinutes;
  final double rating;
  final String description;
  final String director;
  final int colorSeed;
  final MovieCategory category;
  final List<String> castIds;

  /// This movie's id on TMDB (The Movie Database). [PosterBox] uses
  /// it to fetch the real poster and backdrop art at runtime — see
  /// [TmdbService]. Leave null for a movie that isn't on TMDB; the
  /// UI falls back to the gradient placeholder automatically.
  final int? tmdbId;

  const Movie({
    required this.id,
    required this.title,
    required this.tagline,
    required this.genre,
    required this.year,
    required this.durationMinutes,
    required this.rating,
    required this.description,
    required this.director,
    required this.colorSeed,
    required this.category,
    this.castIds = const [],
    this.tmdbId,
  });

  String get durationLabel {
    final h = durationMinutes ~/ 60;
    final m = durationMinutes % 60;
    return '${h}h ${m}m';
  }
}
