import 'package:go_router/go_router.dart';

import '../core/auth/auth_service.dart';
import '../core/constants/app_constants.dart';
import '../core/widgets/app_shell.dart';
import '../features/actor/actor_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/details/details_screen.dart';
import '../features/error/error_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';
import '../features/movies/movies_screen.dart';
import '../features/settings/settings_screen.dart';

/// 👉 LIVE CODING 1: this is the root [GoRouter] — everything the
/// class builds today (route declarations, path parameters, nested
/// routes, a [ShellRoute] for the bottom nav, and an auth redirect)
/// lives in this one file.
final GoRouter appRouter = GoRouter(
  initialLocation: AppConstants.routeHome,
  refreshListenable: AuthService.instance,
  redirect: (context, state) {
    final loggedIn = AuthService.instance.isLoggedIn;
    final goingToLogin = state.matchedLocation == AppConstants.routeLogin;

    if (!loggedIn && !goingToLogin) return AppConstants.routeLogin;
    if (loggedIn && goingToLogin) return AppConstants.routeHome;
    return null;
  },
  errorBuilder: (context, state) => const ErrorScreen(),
  routes: [
    GoRoute(
      path: AppConstants.routeLogin,
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: AppConstants.routeHome,
          builder: (context, state) => const HomeScreen(),
          routes: [
            // 👉 LIVE CODING 2: a nested route — declared as a child
            // of '/', so its full matched path is '/movies'. Reached
            // from HomeScreen's "See All" via context.go('/movies').
            GoRoute(
              path: 'movies',
              builder: (context, state) => const MoviesScreen(),
            ),
          ],
        ),
        GoRoute(
          path: AppConstants.routeFavorites,
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: AppConstants.routeSettings,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          // 👉 LIVE CODING 3: a path *parameter*. `:id` is captured
          // from the URL and read back out via
          // `state.pathParameters['id']` in the builder below.
          path: '/movie/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DetailsScreen(movieId: id);
          },
          routes: [
            // 👉 LIVE CODING 4 / BONUS SESSION: a route nested two
            // levels deep. Its full matched path is
            // '/movie/:id/actor/:actorId' — reached from
            // DetailsScreen's cast row via
            // context.push('/movie/$movieId/actor/${actor.actorId}').
            GoRoute(
              path: 'actor/:actorId',
              builder: (context, state) {
                final actorId = state.pathParameters['actorId']!;
                return ActorScreen(actorId: actorId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
