# CineVerse — Flutter Navigation with go_router

CineVerse is a Christopher Nolan–themed movie browser built to teach
Flutter navigation with [`go_router`](https://pub.dev/packages/go_router).
The `lib/` folder you have is the **finished reference build** — every
screen, widget, and route already works. Inline comments marked
`👉 LIVE CODING N` point at the exact lines that were written live in
each session, so you can use this project two ways:

- **As a student**: read this README top to bottom, then reopen the
  code and find each `👉 LIVE CODING` marker to see the finished
  version of what you built in class.
- **As a live-coding script**: start from the "before" state described
  in each step, and type the "after" code live while the class follows
  along.

## What you'll learn

1. Declaring routes with `GoRouter` and swapping `Navigator.push` for
   `context.go()` / `context.push()`.
2. Nested routes and why URL structure should mirror your navigation
   hierarchy.
3. Path parameters (`:id`) — reading dynamic data out of a URL.
4. Deeper nesting — a route two levels down, and *why* `push` vs `go`
   matters once you get there.
5. `ShellRoute` — a persistent bottom nav bar that survives navigation.
6. **Bonus**: a second dynamic-parameter route, to prove the pattern
   generalizes.
7. **Advanced (optional)**: query parameters, for syncing UI state
   (like a search box) with the URL.

Plus a fully-wired **auth redirect**, which shows how `go_router` can
guard routes without scattering `if (loggedIn)` checks through every
screen.

---

## 0. Project setup

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^14.0.0      # or whatever the current major is
  google_fonts: ^6.0.0
  http: ^1.0.0
```

Run `flutter pub get`, then `flutter run`. The app works immediately
with **no TMDB API key** — every poster, backdrop, and cast photo
falls back to a gradient placeholder (see `core/config/tmdb_config.dart`
and `core/widgets/poster_box.dart` if you want to show students *why*
that fallback exists before wiring up real images). If you do want
real posters for the demo, paste a free TMDB key into
`TmdbConfig.apiKey` — instructions are in that file's doc comment.

Before touching routing, briefly walk through the pieces that are
**not** part of the navigation lesson, so students know they're
pre-built and can be ignored for now:

- `models/` — plain `Movie` and `Actor` data classes.
- `data/movie_repository.dart` — an in-memory "database" (no backend,
  no async, just an in-memory list) so the lesson stays about routing,
  not data fetching.
- `core/theme/` — a design-token system (colors, spacing, type scale).
  Point it out once, then never dwell on it — its whole purpose is to
  make screens look good "for free" so class time goes to routing.
- `core/widgets/todo_snackbar.dart` — a shared helper that pops a
  "🚧 not wired up yet" snackbar. Several buttons (Play, Trailer, Add
  to Favorites, Settings rows) call this instead of navigating,
  because those actions are **out of scope for this lesson** — don't
  wire them up, they're deliberately left as-is.

---

## 1. Before go_router: plain `Navigator`

Start the live coding from a version of `app.dart` that uses a plain
`MaterialApp` and imperative `Navigator.push`, e.g.:

```dart
// BEFORE — imperative navigation, no go_router yet
return MaterialApp(
  title: AppConstants.appName,
  theme: AppTheme.dark,
  home: const HomeScreen(),
);
```

Ask: *what happens if I want a URL for this screen? What happens on
web if I refresh the page? How do I handle "the user isn't logged
in" from fifteen different screens without repeating the same check
everywhere?* That pain is the motivation for `go_router`.

### 👉 LIVE CODING 1 — Declaring the router

Open `lib/router/app_router.dart`. This is the single file where
every route in the app is declared.

```dart
final GoRouter appRouter = GoRouter(
  initialLocation: AppConstants.routeHome,
  routes: [
    GoRoute(
      path: AppConstants.routeHome,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
```

Then swap `MaterialApp` for `MaterialApp.router` in `lib/app.dart`:

```dart
return MaterialApp.router(
  title: AppConstants.appName,
  theme: AppTheme.dark,
  routerConfig: appRouter,
);
```

Run the app — nothing looks different yet, but you're now on
`go_router`. This is the moment to mention that every route path in
this project lives in `AppConstants` (`lib/core/constants/app_constants.dart`)
rather than being retyped as a raw string everywhere — one small
habit that avoids an entire class of typo bugs later ("wait, why
doesn't `/Movies` navigate anywhere?").

---

## 2. Nested routes

### 👉 LIVE CODING 2 — `/movies`

`MoviesScreen` (`lib/features/movies/movies_screen.dart`) already
exists as a widget — it just isn't reachable yet. Add it as a **child**
route of home:

```dart
GoRoute(
  path: AppConstants.routeHome,
  builder: (context, state) => const HomeScreen(),
  routes: [
    GoRoute(
      path: 'movies',              // note: no leading slash — it's
      builder: (context, state) => // relative to the parent, so the
          const MoviesScreen(),    // full path becomes '/movies'.
    ),
  ],
),
```

Then in `home_screen.dart`, wire up the three "See All" buttons:

```dart
SectionHeader(
  title: 'Trending Now',
  onSeeAll: () => context.go(AppConstants.routeMovies),
),
```

Talk through **why the child path has no leading slash** — `go_router`
concatenates it with the parent to build `/movies`. This is the core
idea behind nested routing: your route *tree* should mirror your
*navigation* tree, not just be a flat list of screens.

---

## 3. Path parameters

### 👉 LIVE CODING 3 — `/movie/:id`

Right now `DetailsScreen` takes `movieId` as a plain constructor
argument (see the doc comment at the top of
`lib/features/details/details_screen.dart` — it explains exactly this
transition). Add the route:

```dart
GoRoute(
  path: '/movie/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return DetailsScreen(movieId: id);
  },
),
```

Then wire up every place a movie card is tapped — `MoviesScreen` and
the `_MovieRow` inside `HomeScreen` both already call:

```dart
onTap: () => context.push('/movie/${movie.id}'),
```

**Ask the class**: why `push` here instead of `go`? `push` adds to the
stack (so the back button returns to the grid/row you tapped from);
`go` replaces the current location. Details screens are exactly the
"drill in, then come back" pattern `push` is for.

---

## 4. A route nested two levels deep

### 👉 LIVE CODING 4 — `/movie/:id/actor/:actorId`

Each movie's cast row (`_CastRow` inside `details_screen.dart`) needs
to open an actor bio. Nest the actor route under the movie route:

```dart
GoRoute(
  path: '/movie/:id',
  builder: (context, state) { /* ...as above... */ },
  routes: [
    GoRoute(
      path: 'actor/:actorId',
      builder: (context, state) {
        final actorId = state.pathParameters['actorId']!;
        return ActorScreen(actorId: actorId);
      },
    ),
  ],
),
```

Then in `_CastRow`, replace the `showTodoSnackbar` placeholder on each
actor's `GestureDetector` with:

```dart
onTap: () => context.push('/movie/$movieId/actor/${actor.actorId}'),
```

Two things worth calling out live:

- The full matched path is `/movie/:id/actor/:actorId` — two path
  parameters, both read out independently in their own `builder`.
- This is a second, independent proof of the *same* pattern from
  Step 3 — a good moment to pause and let students predict the route
  declaration themselves before you type it.

---

## 5. `ShellRoute` — a persistent bottom nav bar

This is usually the trickiest concept, so it's worth setting up the
"before" clearly. Open `lib/features/home/home_screen.dart` and look
at the commented-out `_HomeBottomNav` class at the bottom of the file
— that's the **before** version: a `BottomNavigationBar` built
directly into `HomeScreen`, using `Navigator`/`context.go` calls of
its own.

Ask: *if I add the same bottom nav bar to `FavoritesScreen` and
`SettingsScreen`, what happens when I navigate between tabs?* Answer:
the bar disappears and reappears, and (depending on how it's wired)
navigating away from Home loses it entirely — because it's scoped to
one screen's widget tree, not to the app shell.

### 👉 LIVE CODING 5 — the fix: `ShellRoute` + `AppShell`

`lib/core/widgets/app_shell.dart` is the *shared* nav bar shell. It
takes a `child` (whichever tab screen is currently active) and always
renders the `BottomNavigationBar` around it:

```dart
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static const _tabPaths = [
    AppConstants.routeHome,
    AppConstants.routeFavorites,
    AppConstants.routeSettings,
  ];

  int _indexForLocation(String location) {
    if (location.startsWith(AppConstants.routeFavorites)) return 1;
    if (location.startsWith(AppConstants.routeSettings)) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexForLocation(location),
        onTap: (index) => context.go(_tabPaths[index]),
        items: const [/* ... */],
      ),
    );
  }
}
```

Wrap the tab routes in a `ShellRoute` in `app_router.dart`:

```dart
ShellRoute(
  builder: (context, state, child) => AppShell(child: child),
  routes: [
    GoRoute(path: AppConstants.routeHome, /* ...with its `movies` child... */),
    GoRoute(path: AppConstants.routeFavorites, builder: (_, __) => const FavoritesScreen()),
    GoRoute(path: AppConstants.routeSettings, builder: (_, __) => const SettingsScreen()),
    GoRoute(path: '/movie/:id', /* ...with its `actor/:actorId` child... */),
  ],
),
```

Now delete (or leave commented, for reference) the old
`_HomeBottomNav` — `AppShell` has fully replaced it, and it now wraps
**every** route inside the `ShellRoute`, not just Home.

> **Optional extension for a follow-up session**: this project uses a
> plain `ShellRoute`, which rebuilds each tab's screen from scratch
> every time you switch tabs (so e.g. scroll position on the Movies
> grid resets). `go_router` also offers `StatefulShellRoute.indexedStack`,
> which keeps each tab's navigator (and its state) alive in the
> background using an `IndexedStack`. It's a natural "part 2" topic
> once students are comfortable with the basics here.

---

## 6. Bonus session — a second dynamic route, on your own

`lib/features/actor/actor_screen.dart` is intentionally left with a
`👉 BONUS SESSION` comment. By the time you reach this file, the
`/movie/:id/actor/:actorId` route from Step 4 already reaches it — so
use this as a **review exercise**: close the router file, and have
students describe (or write from scratch) the nested `GoRoute` that
must exist for `ActorScreen` to be reachable, before you show them
that it's already there. It's good reinforcement precisely because
it *looks* new but is exactly the Step 3/4 pattern again.

---

## 7. Advanced (optional) — query parameters

`lib/features/search/search_screen.dart` is fully built (a
`TextField` wired to `MovieRepository.instance.search(...)`) but is
**deliberately not added to the router**. Once students are
comfortable with path parameters, this is a good next step for
syncing UI state with the URL using **query** parameters instead:

```dart
GoRoute(
  path: '/search',
  builder: (context, state) {
    final query = state.uri.queryParameters['q'] ?? '';
    return SearchScreen(initialQuery: query);
  },
),
```

This requires a small change to `SearchScreen` itself (accepting an
`initialQuery`, and calling `context.replace('/search?q=$value')` — or
similar — as the user types) which isn't in the starter file, by
design: it's meant to be built live or set as homework, not read off
the page.

---

## 8. Auth redirect — guarding routes without per-screen checks

Once the class has the basics down, `app_router.dart`'s `redirect`
callback is worth a dedicated look:

```dart
redirect: (context, state) {
  final loggedIn = AuthService.instance.isLoggedIn;
  final goingToLogin = state.matchedLocation == AppConstants.routeLogin;

  if (!loggedIn && !goingToLogin) return AppConstants.routeLogin;
  if (loggedIn && goingToLogin) return AppConstants.routeHome;
  return null; // no redirect needed
},
```

Two points worth emphasizing:

- `refreshListenable: AuthService.instance` — `AuthService` is a
  `ChangeNotifier`; `go_router` re-evaluates `redirect` every time it
  calls `notifyListeners()`. This is why logging in from
  `LoginScreen` (`AuthService.instance.login()`) is enough to bounce
  the user to `/` with no manual navigation call at all.
- `AuthService` here is a deliberately simple in-memory singleton — it
  resets on every hot restart / app relaunch. That's fine for
  teaching the redirect mechanism, but call it out explicitly so no
  one assumes it's production-ready auth.

---

## Quick reference — every route in the finished app

| Path | Screen | Notes |
|---|---|---|
| `/login` | `LoginScreen` | outside the `ShellRoute` — no bottom nav |
| `/` | `HomeScreen` | tab 1 |
| `/movies` | `MoviesScreen` | nested under `/` |
| `/favorites` | `FavoritesScreen` | tab 2 |
| `/settings` | `SettingsScreen` | tab 3 |
| `/movie/:id` | `DetailsScreen` | path parameter `id` |
| `/movie/:id/actor/:actorId` | `ActorScreen` | nested two levels, path parameter `actorId` |
| *(any unmatched path)* | `ErrorScreen` | via `errorBuilder` |

## What's intentionally left unfinished

- `SearchScreen` exists but has no route — save it for the "Advanced"
  session on query parameters.
- The search icon on Home, the Play/Trailer buttons on the details
  screen and featured banner, "Add to Favorites", and every Settings
  row call `showTodoSnackbar()` instead of navigating anywhere. None
  of these are routing gaps — they're features outside this lesson's
  scope (actually favoriting a movie, playing video, editing a
  profile), left as an honest "not built yet" rather than faked.
