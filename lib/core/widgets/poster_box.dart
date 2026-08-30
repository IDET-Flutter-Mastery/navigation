import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_durations.dart';
import '../theme/app_radius.dart';
import '../theme/app_sizes.dart';

/// Which TMDB image to show inside a [PosterBox].
enum PosterImageKind { poster, backdrop }

/// A movie "poster" surface — a cyan/magenta gradient base that a
/// real TMDB poster or backdrop image fades in on top of.
///
/// The gradient (picked from [AppColors.gradientFor]) is always
/// there first, so the layout never pops or flashes white: while the
/// TMDB image is loading, or if it fails to load (no API key set
/// yet, no wifi, a bad id, offline classroom demo, etc.), the
/// gradient is exactly what's shown — there's no broken-image icon,
/// ever.
class PosterBox extends StatelessWidget {
  final int colorSeed;
  final int? tmdbId;
  final PosterImageKind kind;
  final double borderRadius;
  final Widget? child;
  final BoxFit fit;

  const PosterBox({
    super.key,
    required this.colorSeed,
    this.tmdbId,
    this.kind = PosterImageKind.poster,
    this.borderRadius = AppRadius.lg,
    this.child,
    this.fit = BoxFit.cover,
  });

  Future<String?> _resolveImageUrl() {
    if (tmdbId == null) return Future.value(null);
    return kind == PosterImageKind.poster
        ? TmdbService.instance.posterUrl(tmdbId!)
        : TmdbService.instance.backdropUrl(tmdbId!);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.gradientFor(colorSeed);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Watermark shown until (or unless) a real image loads.
            const Opacity(
              opacity: 0.18,
              child: Icon(
                Icons.local_movies_rounded,
                size: AppSizes.iconHero,
                color: Colors.white,
              ),
            ),
            if (tmdbId != null)
              FutureBuilder<String?>(
                future: _resolveImageUrl(),
                builder: (context, snapshot) {
                  final url = snapshot.data;
                  if (url == null) return const SizedBox.shrink();
                  return Image.network(
                    url,
                    fit: fit,
                    gaplessPlayback: true,
                    frameBuilder: (context, widget, frame, wasSyncLoaded) {
                      if (wasSyncLoaded) return widget;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: AppDurations.medium,
                        curve: Curves.easeOut,
                        child: widget,
                      );
                    },
                    // Network hiccup or bad URL — just keep the gradient.
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  );
                },
              ),
            // A soft bottom scrim so any overlaid text/badges stay
            // legible over a bright photo, not just the gradient.
            if (child != null)
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xCC090B10)],
                    stops: [0.45, 1.0],
                  ),
                ),
              ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
