import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';

/// 👉 LIVE CODING 5: the [ShellRoute] wraps every tab screen with
/// this persistent bottom nav bar, so it stays on screen across
/// navigations instead of disappearing outside of HomeScreen — see
/// the commented-out `_HomeBottomNav` in `home_screen.dart` for the
/// "before" version this replaces.
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
    final currentIndex = _indexForLocation(location);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => context.go(_tabPaths[index]),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}
