import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/actor_avatar.dart';
import '../../data/movie_repository.dart';

/// 👉 BONUS SESSION: reached via the nested route
/// `/movie/:id/actor/:actorId` declared in `app_router.dart`, using
/// the same path-parameter technique as `DetailsScreen`. See
/// `_CastRow` in `details_screen.dart` for the `context.push()` call
/// that lands here.
class ActorScreen extends StatelessWidget {
  final String actorId;

  const ActorScreen({super.key, required this.actorId});

  @override
  Widget build(BuildContext context) {
    final actor = MovieRepository.instance.getActorById(actorId);

    if (actor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: const Center(child: Text('No actor with that id.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(actor.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ActorAvatar(actor: actor, radius: AppSizes.avatarMd),
            ),
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: Text(actor.name, style: AppTypography.screenTitle),
            ),
            const SizedBox(height: AppSpacing.xs),
            Center(
              child: Text(
                'as ${actor.character}',
                style:
                    AppTypography.bodyLarge.copyWith(color: AppColors.primary),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('About', style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Text(
              actor.bio,
              style: AppTypography.overview
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
