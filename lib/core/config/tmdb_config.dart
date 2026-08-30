/// TMDB (The Movie Database) API configuration.
///
/// CineVerse fetches real poster, backdrop, and cast photos from
/// TMDB at runtime — this is exactly what TMDB's free API is meant
/// for, and is the standard, legitimate way movie apps source images.
///
/// 👉 Setup (2 minutes, free):
///   1. Create an account at https://www.themoviedb.org/signup
///   2. Go to Settings → API → request an API key (choose "Developer")
///   3. Paste EITHER key below:
///      - the "API Key (v3 auth)" — a short string, or
///      - the "API Read Access Token" (v4 auth) — a long string
///        starting with "eyJ"
///      CineVerse detects which kind you pasted and calls TMDB
///      correctly either way.
///
/// Until a key is added, [isConfigured] is false and every image
/// request in the app short-circuits to `null` — screens simply show
/// their gradient placeholder instead. Nothing crashes, nothing
/// shows a broken-image icon; the app is just as safe to run on day
/// one of class as it is once TMDB is wired up.
class TmdbConfig {
  TmdbConfig._();

  /// 👉 Paste your TMDB API key or read access token here.
  static const String apiKey = 'YOUR_TMDB_API_KEY';

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  static bool get isConfigured =>
      apiKey.trim().isNotEmpty && apiKey != 'YOUR_TMDB_API_KEY';

  /// v4 read access tokens are long JWTs and always start with this.
  static bool get _isBearerToken => apiKey.startsWith('eyJ');

  /// Query parameters every request needs (v3-style key only).
  static Map<String, String> get queryParams =>
      _isBearerToken ? const {} : {'api_key': apiKey};

  /// Headers every request needs (v4-style bearer token only).
  static Map<String, String> get headers => _isBearerToken
      ? {'Authorization': 'Bearer $apiKey', 'Accept': 'application/json'}
      : const {'Accept': 'application/json'};
}
