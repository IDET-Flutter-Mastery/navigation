import 'package:flutter/material.dart';
import '../../models/actor.dart';
import '../services/tmdb_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// A circular cast photo — a real TMDB headshot when [Actor.tmdbPersonId]
/// is set, gracefully falling back to a gradient-and-initials avatar
/// (same trick as [PosterBox]) if there's no id, no API key
/// configured yet, or the request fails.
class ActorAvatar extends StatelessWidget {
  final Actor actor;
  final double radius;

  const ActorAvatar({super.key, required this.actor, required this.radius});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.gradientFor(actor.colorSeed);
    final initials = Text(
      actor.initials,
      style:
          (radius >= 40 ? AppTypography.screenTitle : AppTypography.titleSmall)
              .copyWith(color: Colors.white),
    );

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: actor.tmdbPersonId == null
          ? Center(child: initials)
          : FutureBuilder<String?>(
              future: TmdbService.instance.profileUrl(actor.tmdbPersonId!),
              builder: (context, snapshot) {
                final url = snapshot.data;
                if (url == null) return Center(child: initials);
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child: initials),
                );
              },
            ),
    );
  }
}
