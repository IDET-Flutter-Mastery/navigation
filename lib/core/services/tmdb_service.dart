import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/tmdb_config.dart';

/// A tiny, cached wrapper around the two bits of the TMDB API
/// CineVerse needs: a movie's poster/backdrop paths, and a cast
/// member's profile photo path.
///
/// Every lookup is cached in memory (by TMDB id) after the first
/// call — including in-flight requests — so scrolling a row back and
/// forth, or a poster and its details-screen backdrop both wanting
/// the same movie, never re-hits the network twice.
///
/// Every public method resolves to `null` instead of throwing: no
/// API key configured, no wifi, a bad id, a timeout, a non-200
/// response — all of it just means "no image today." Callers (see
/// [PosterBox] and [ActorAvatar]) already know how to fall back to
/// the gradient placeholder when that happens.
class TmdbService {
  TmdbService._();
  static final TmdbService instance = TmdbService._();

  final Map<int, Future<Map<String, dynamic>?>> _movieCache = {};
  final Map<int, Future<Map<String, dynamic>?>> _personCache = {};

  Future<Map<String, dynamic>?> _get(String path) async {
    if (!TmdbConfig.isConfigured) return null;
    try {
      final uri = Uri.parse('${TmdbConfig.baseUrl}$path').replace(
        queryParameters: TmdbConfig.queryParams,
      );
      final response = await http
          .get(uri, headers: TmdbConfig.headers)
          .timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return null;
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      // Offline, DNS hiccup, malformed JSON, whatever — no image today.
      return null;
    }
  }

  Future<Map<String, dynamic>?> _movie(int tmdbId) =>
      _movieCache.putIfAbsent(tmdbId, () => _get('/movie/$tmdbId'));

  Future<Map<String, dynamic>?> _person(int tmdbId) =>
      _personCache.putIfAbsent(tmdbId, () => _get('/person/$tmdbId'));

  /// Full poster image URL for a movie, or `null`.
  Future<String?> posterUrl(int tmdbId, {String size = 'w500'}) async {
    final path = (await _movie(tmdbId))?['poster_path'] as String?;
    return path == null ? null : '${TmdbConfig.imageBaseUrl}/$size$path';
  }

  /// Full backdrop (widescreen) image URL for a movie, or `null`.
  Future<String?> backdropUrl(int tmdbId, {String size = 'w1280'}) async {
    final path = (await _movie(tmdbId))?['backdrop_path'] as String?;
    return path == null ? null : '${TmdbConfig.imageBaseUrl}/$size$path';
  }

  /// Full headshot image URL for a cast member, or `null`.
  Future<String?> profileUrl(int tmdbId, {String size = 'w300'}) async {
    final path = (await _person(tmdbId))?['profile_path'] as String?;
    return path == null ? null : '${TmdbConfig.imageBaseUrl}/$size$path';
  }
}
