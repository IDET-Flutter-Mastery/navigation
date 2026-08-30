import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A single source of truth for every text style in the app, set in
/// **Lexend** — CineVerse's typeface.
///
/// Screens should reach for these instead of writing `TextStyle(
/// fontSize: 19, fontWeight: FontWeight.w800)` inline — that way a
/// single tweak here updates every headline in the app consistently.
/// Use `.copyWith(color: ...)` at the call site when a style needs a
/// non-default color.
///
/// The first block matches the CineVerse type spec 1:1 (component →
/// size/weight). The second block is a supplementary scale for
/// everything the spec doesn't name directly (buttons, pills, list
/// tiles, footnotes) kept in the same Lexend family and rhythm.
class AppTypography {
  AppTypography._();

  // ── Spec-named styles ────────────────────────────────────────
  /// App Logo — 30 / Bold.
  static TextStyle get appLogo => GoogleFonts.lexend(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        height: 1.15,
      );

  /// Screen Title — 24 / Bold.
  static TextStyle get screenTitle => GoogleFonts.lexend(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        height: 1.2,
      );

  /// Section Title — 20 / SemiBold.
  static TextStyle get sectionTitle => GoogleFonts.lexend(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.25,
      );

  /// Movie Title — 18 / SemiBold.
  static TextStyle get movieTitle => GoogleFonts.lexend(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  /// Genre — 13 / Medium.
  static TextStyle get genre => GoogleFonts.lexend(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  /// Rating — 14 / SemiBold.
  static TextStyle get rating => GoogleFonts.lexend(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  /// Overview — 15 / Regular.
  static TextStyle get overview => GoogleFonts.lexend(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  /// Bottom Nav — 12 / Medium.
  static TextStyle get bottomNav => GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  // ── Supplementary scale ──────────────────────────────────────
  static TextStyle get titleSmall => GoogleFonts.lexend(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.3,
      );

  /// General-purpose body copy. Deliberately identical to
  /// [overview] — the "Overview" spec size (15/Regular) doubles as
  /// the app's default paragraph style.
  static TextStyle get bodyLarge => GoogleFonts.lexend(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.lexend(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        height: 1.45,
      );

  static TextStyle get bodySmall => GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  /// Button labels.
  static TextStyle get labelLarge => GoogleFonts.lexend(
        fontSize: 13.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      );

  static TextStyle get labelMedium => GoogleFonts.lexend(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      );

  static TextStyle get labelSmall => GoogleFonts.lexend(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      );

  /// For section eyebrows like "ACCOUNT" in Settings.
  static TextStyle get overline => GoogleFonts.lexend(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      );
}
