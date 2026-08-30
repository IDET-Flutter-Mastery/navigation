/// Fixed component dimensions used across more than one screen.
/// Anything reused twice belongs here rather than typed twice.
class AppSizes {
  AppSizes._();

  // Icons
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 28;
  static const double iconHero = 64;

  // Avatars
  static const double avatarSm = 32;
  static const double avatarMd = 56;

  // Movie poster cards (home rows + grid)
  static const double movieCardWidth = 148;
  // Poster (2:3 @ 148w = 222) + title/genre text block at the
  // spec type scale (Movie Title 18/600 + Genre 13/500) needs ~60px
  // — sized with headroom so nothing clips.
  static const double movieRowHeight = 284;
  static const double posterAspectRatio = 2 / 3;

  // Featured banner
  static const double bannerAspectRatio = 16 / 10;

  // Grid layout (Movies / Search screens) — tuned so the same
  // poster + text block above never overflows a grid cell, even on
  // the narrowest supported phone widths.
  static const int gridCrossAxisCount = 2;
  static const double gridAspectRatio = 0.5;

  // Cast row (Details screen)
  static const double castAvatarRadius = 32;
  static const double castItemWidth = 76;
  static const double castRowHeight = 118;

  // Details screen hero
  static const double detailsHeaderHeight = 320;

  // Touch targets — never go below Material's 48dp minimum.
  static const double minTouchTarget = 48;
}
