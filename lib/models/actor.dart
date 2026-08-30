class Actor {
  final String actorId;
  final String name;
  final String character;
  final int colorSeed;
  final String bio;

  /// This actor's id on TMDB (The Movie Database). [ActorAvatar] uses
  /// it to fetch a real headshot at runtime — see [TmdbService].
  /// Leave null to always show the gradient + initials avatar.
  final int? tmdbPersonId;

  const Actor({
    required this.actorId,
    required this.name,
    required this.character,
    required this.colorSeed,
    required this.bio,
    this.tmdbPersonId,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
