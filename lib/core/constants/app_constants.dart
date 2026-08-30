class AppConstants {
  AppConstants._();

  static const String appName = 'CineVerse';
  static const String tagline = 'Your next favorite movie is one tap away.';

  // Route paths — the single source of truth for every literal path
  // string in the app. `app_router.dart` and `app_shell.dart` both
  // reference these instead of retyping raw strings, so a path can
  // never drift out of sync between "where a route is declared" and
  // "where we navigate to it".
  static const String routeLogin = '/login';
  static const String routeHome = '/';
  static const String routeMovies = '/movies';
  static const String routeMovieDetails = '/movie/:id';
  static const String routeActor = '/actor/:actorId';
  static const String routeSearch = '/search';
  static const String routeFavorites = '/favorites';
  static const String routeSettings = '/settings';
}
