import 'package:flutter/material.dart';

/// CineVerse color palette — a neon-noir cinematic dark theme built
/// around a cyan/magenta duotone accent system.
///
/// Screens and widgets should always reach for a named color here
/// instead of a bare `Color(0xFF...)` — that's what makes a
/// palette-wide tweak a one-file change.
class AppColors {
  AppColors._();

  // ── Surfaces ──────────────────────────────────────────────────
  /// Base app background — "Midnight Black".
  static const Color background = Color(0xFF090B10);

  /// Card / row surface — "Dark Slate".
  static const Color surface = Color(0xFF141923);

  /// Raised surface (app bars, sheets, nav bar) — "Gunmetal".
  static const Color surfaceElevated = Color(0xFF1D2430);

  /// Hairline dividers and unfilled borders.
  static const Color divider = Color(0xFF283142);

  // ── Accents ───────────────────────────────────────────────────
  /// Primary accent — "Neon Cyan". Primary buttons, active nav,
  /// progress indicators, links.
  static const Color primary = Color(0xFF4FFFFC);

  /// Secondary accent — "Deep Magenta". Secondary buttons, filled
  /// favorite icon, selected chips.
  static const Color secondary = Color(0xFF8F106B);

  /// The signature CineVerse duotone, cyan → magenta. Great for
  /// splash art, login screens, and featured banners.
  static const List<Color> heroGradient = [primary, secondary];

  // ── Text ──────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFB7C1CF);
  static const Color textMuted = Color(0xFF7A8596);

  // ── Status ────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);

  /// Star-rating gold — kept distinct from the accent pair so
  /// ratings always read clearly against either one.
  static const Color ratingStar = Color(0xFFFFD54F);

  /// A rotating set of cyan/magenta-family gradient pairs. Used as
  /// the base layer behind every poster — visible instantly, then
  /// a network image (if any) fades in on top of it, and it's the
  /// permanent look whenever there's no image or the network fails.
  static const List<List<Color>> posterGradients = [
    [Color(0xFF4FFFFC), Color(0xFF1D2430)],
    [Color(0xFF8F106B), Color(0xFF1D2430)],
    [Color(0xFF4FFFFC), Color(0xFF8F106B)],
    [Color(0xFF2E3A59), Color(0xFF8F106B)],
    [Color.fromARGB(255, 156, 180, 179), Color(0xFF141923)],
    [Color(0xFF6D28D9), Color(0xFF1D2430)],
    [Color(0xFF8F106B), Color(0xFF4FFFFC)],
    [Color(0xFF1D4ED8), Color(0xFF4FFFFC)],
    [Color(0xFFB91C6B), Color(0xFF2E1065)],
    [Color(0xFF0891B2), Color(0xFF312E81)],
    [Color(0xFFDB2777), Color(0xFF1E1B4B)],
    [Color(0xFF14B8A6), Color(0xFF4C1D95)],
  ];

  static List<Color> gradientFor(int seed) {
    return posterGradients[seed % posterGradients.length];
  }
}
