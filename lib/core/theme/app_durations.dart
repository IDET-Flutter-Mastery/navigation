/// Consistent motion timing. Prefer these over ad-hoc
/// `Duration(milliseconds: 200)` calls so animations feel like one
/// coherent system rather than a grab-bag of speeds.
class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  static const Duration snackbar = Duration(seconds: 3);
}
