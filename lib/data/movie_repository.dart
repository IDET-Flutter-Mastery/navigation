import '../models/actor.dart';
import '../models/movie.dart';

/// A fully in-memory data source — no backend, no auth token, no
/// pagination — so the navigation lecture stays focused on
/// `go_router`, not data fetching.
///
/// The catalog is the real filmography of **Christopher Nolan**.
/// Every [Movie.tmdbId] / [Actor.tmdbPersonId] below is a real TMDB
/// id, so once you add an API key in `core/config/tmdb_config.dart`,
/// posters, backdrops, and cast photos all come from TMDB for real —
/// no placeholder images anywhere. Until then, [PosterBox] and
/// [ActorAvatar] fall back to gradient placeholders automatically,
/// so the app is just as safe to run without a key.
class MovieRepository {
  MovieRepository._();
  static final MovieRepository instance = MovieRepository._();

  final List<Actor> _actors = const [
    Actor(
      actorId: 'a1',
      name: 'Christian Bale',
      character: 'Bruce Wayne / Batman',
      colorSeed: 0,
      tmdbPersonId: 3894,
      bio: 'Known for intense physical transformations, Christian Bale '
          'anchored Nolan\'s Batman trilogy as Bruce Wayne.',
    ),
    Actor(
      actorId: 'a2',
      name: 'Michael Caine',
      character: 'Alfred Pennyworth',
      colorSeed: 1,
      tmdbPersonId: 3895,
      bio: 'A Nolan regular since 2005, Michael Caine has appeared in '
          'nearly every one of the director\'s films since Batman Begins.',
    ),
    Actor(
      actorId: 'a3',
      name: 'Cillian Murphy',
      character: 'J. Robert Oppenheimer',
      colorSeed: 2,
      tmdbPersonId: 2037,
      bio: 'Cillian Murphy\'s piercing screen presence made him a Nolan '
          'mainstay, culminating in an Academy Award-winning lead role '
          'in Oppenheimer.',
    ),
    Actor(
      actorId: 'a4',
      name: 'Tom Hardy',
      character: 'Eames / Bane',
      colorSeed: 3,
      tmdbPersonId: 2524,
      bio: 'Tom Hardy brought physicality and gravel-voiced presence to '
          'roles across Inception, The Dark Knight Rises, and Dunkirk.',
    ),
    Actor(
      actorId: 'a5',
      name: 'Leonardo DiCaprio',
      character: 'Dom Cobb',
      colorSeed: 4,
      tmdbPersonId: 6193,
      bio: 'Leonardo DiCaprio led Inception as Dom Cobb, a thief who '
          'steals secrets from people\'s dreams.',
    ),
    Actor(
      actorId: 'a6',
      name: 'Matthew McConaughey',
      character: 'Cooper',
      colorSeed: 5,
      tmdbPersonId: 10297,
      bio: 'Matthew McConaughey starred as the pilot-turned-explorer '
          'Cooper in Nolan\'s space epic Interstellar.',
    ),
    Actor(
      actorId: 'a7',
      name: 'Heath Ledger',
      character: 'The Joker',
      colorSeed: 6,
      tmdbPersonId: 1810,
      bio: 'Heath Ledger\'s portrayal of the Joker in The Dark Knight '
          'earned him a posthumous Academy Award.',
    ),
    Actor(
      actorId: 'a8',
      name: 'John David Washington',
      character: 'The Protagonist',
      colorSeed: 7,
      tmdbPersonId: 1117313,
      bio: 'John David Washington led Tenet as the enigmatic Protagonist, '
          'navigating a world of inverted time.',
    ),
    Actor(
      actorId: 'a9',
      name: 'Elizabeth Debicki',
      character: 'Kat Barton',
      colorSeed: 8,
      tmdbPersonId: 1133349,
      bio: 'Elizabeth Debicki played Kat, a mother drawn into Tenet\'s '
          'time-bending conspiracy.',
    ),
    Actor(
      actorId: 'a10',
      name: 'Anne Hathaway',
      character: 'Amelia Brand',
      colorSeed: 9,
      tmdbPersonId: 1813,
      bio: 'Anne Hathaway appeared in Nolan\'s The Dark Knight Rises and '
          'later starred in Interstellar as scientist-astronaut Amelia Brand.',
    ),
    Actor(
      actorId: 'a11',
      name: 'Joseph Gordon-Levitt',
      character: 'Arthur',
      colorSeed: 10,
      tmdbPersonId: 24045,
      bio: 'Joseph Gordon-Levitt played Cobb\'s sharp-witted partner '
          'Arthur in Inception.',
    ),
    Actor(
      actorId: 'a12',
      name: 'Marion Cotillard',
      character: 'Mal Cobb',
      colorSeed: 11,
      tmdbPersonId: 8293,
      bio: 'Marion Cotillard portrayed Mal, the haunting projection of '
          'Cobb\'s late wife in Inception.',
    ),
    Actor(
      actorId: 'a13',
      name: 'Guy Pearce',
      character: 'Leonard Shelby',
      colorSeed: 0,
      tmdbPersonId: 529,
      bio: 'Guy Pearce carried Memento as Leonard Shelby, a man piecing '
          'together his life with a short-term memory condition.',
    ),
    Actor(
      actorId: 'a14',
      name: 'Al Pacino',
      character: 'Will Dormer',
      colorSeed: 1,
      tmdbPersonId: 1158,
      bio: 'Al Pacino starred as an insomniac detective in Nolan\'s '
          'Alaska-set thriller Insomnia.',
    ),
    Actor(
      actorId: 'a15',
      name: 'Hugh Jackman',
      character: 'Robert Angier',
      colorSeed: 2,
      tmdbPersonId: 6968,
      bio: 'Hugh Jackman played rival stage magician Robert Angier in '
          'the mystery-drama The Prestige.',
    ),
    Actor(
      actorId: 'a16',
      name: 'Emily Blunt',
      character: 'Kitty Oppenheimer',
      colorSeed: 3,
      tmdbPersonId: 5081,
      bio: 'Emily Blunt portrayed Kitty Oppenheimer in Nolan\'s '
          'biographical drama Oppenheimer.',
    ),
  ];

  final List<Movie> _movies = const [
    Movie(
      id: 'm1',
      title: 'Following',
      tagline: 'One choice can unravel everything.',
      genre: 'Neo-Noir',
      year: 1998,
      durationMinutes: 69,
      rating: 7.5,
      description: 'A struggling writer follows strangers through London for '
          'inspiration, until one man draws him into a web of theft and '
          'deception that spirals far beyond his control.',
      director: 'Christopher Nolan',
      colorSeed: 0,
      category: MovieCategory.newRelease,
      castIds: [],
      tmdbId: 11660,
    ),
    Movie(
      id: 'm2',
      title: 'Memento',
      tagline: 'Some memories are best forgotten. He can\'t.',
      genre: 'Mystery',
      year: 2000,
      durationMinutes: 113,
      rating: 8.4,
      description:
          'Told in fractured, reverse chronology, a man unable to form '
          'new memories hunts for his wife\'s killer using notes, '
          'Polaroids, and tattoos as the only memory he can trust.',
      director: 'Christopher Nolan',
      colorSeed: 1,
      category: MovieCategory.topRated,
      castIds: ['a13'],
      tmdbId: 77,
    ),
    Movie(
      id: 'm3',
      title: 'Insomnia',
      tagline: 'In the land of the midnight sun, no one sleeps.',
      genre: 'Thriller',
      year: 2002,
      durationMinutes: 118,
      rating: 7.2,
      description:
          'A veteran detective investigates a murder in a small Alaskan '
          'town where the sun never sets, and a fatal mistake in the '
          'field pulls him into a dangerous game with the man he\'s hunting.',
      director: 'Christopher Nolan',
      colorSeed: 2,
      category: MovieCategory.newRelease,
      castIds: ['a14'],
      tmdbId: 320,
    ),
    Movie(
      id: 'm4',
      title: 'Batman Begins',
      tagline: 'Fear becomes his greatest weapon.',
      genre: 'Action',
      year: 2005,
      durationMinutes: 140,
      rating: 8.2,
      description:
          'After training with a secretive league of shadows, Bruce Wayne '
          'returns to Gotham City to forge himself into a symbol that can '
          'strike fear into the criminals who have overrun it.',
      director: 'Christopher Nolan',
      colorSeed: 3,
      category: MovieCategory.newRelease,
      castIds: ['a1', 'a2', 'a3'],
      tmdbId: 272,
    ),
    Movie(
      id: 'm5',
      title: 'The Prestige',
      tagline: 'Are you watching closely?',
      genre: 'Drama',
      year: 2006,
      durationMinutes: 130,
      rating: 8.5,
      description: 'Two rival stage magicians in Victorian London engage in an '
          'escalating battle of sabotage and obsession, each willing to '
          'pay any price to perform the ultimate illusion.',
      director: 'Christopher Nolan',
      colorSeed: 4,
      category: MovieCategory.topRated,
      castIds: ['a15', 'a1', 'a2'],
      tmdbId: 1124,
    ),
    Movie(
      id: 'm6',
      title: 'The Dark Knight',
      tagline: 'Some men just want to watch the world burn.',
      genre: 'Action',
      year: 2008,
      durationMinutes: 152,
      rating: 9.0,
      description: 'As Batman, Lieutenant Gordon, and District Attorney Harvey '
          'Dent take on Gotham\'s organized crime, a chaotic new threat '
          'known as the Joker emerges to test the limits of the city\'s heroes.',
      director: 'Christopher Nolan',
      colorSeed: 5,
      category: MovieCategory.topRated,
      castIds: ['a1', 'a7', 'a2'],
      tmdbId: 155,
    ),
    Movie(
      id: 'm7',
      title: 'Inception',
      tagline: 'A heist through the architecture of the mind.',
      genre: 'Sci-Fi',
      year: 2010,
      durationMinutes: 148,
      rating: 8.8,
      description:
          'A skilled thief who steals secrets from people\'s dreams is '
          'offered a chance to have his criminal record erased in exchange '
          'for planting an idea deep in a target\'s subconscious.',
      director: 'Christopher Nolan',
      colorSeed: 6,
      category: MovieCategory.trending,
      castIds: ['a5', 'a11', 'a4'],
      tmdbId: 27205,
    ),
    Movie(
      id: 'm8',
      title: 'The Dark Knight Rises',
      tagline: 'The legend ends.',
      genre: 'Action',
      year: 2012,
      durationMinutes: 164,
      rating: 8.4,
      description:
          'Eight years after taking the blame for Harvey Dent\'s crimes, a '
          'weary Bruce Wayne is forced back into the cowl when the masked '
          'mercenary Bane threatens to destroy Gotham City.',
      director: 'Christopher Nolan',
      colorSeed: 7,
      category: MovieCategory.newRelease,
      castIds: ['a1', 'a4', 'a10'],
      tmdbId: 49026,
    ),
    Movie(
      id: 'm9',
      title: 'Interstellar',
      tagline: 'Mankind was born on Earth. It was never meant to die here.',
      genre: 'Sci-Fi',
      year: 2014,
      durationMinutes: 169,
      rating: 8.7,
      description:
          'As Earth grows increasingly inhospitable, a former pilot leads '
          'a crew of explorers through a wormhole in search of a new home '
          'for humanity, racing against time itself.',
      director: 'Christopher Nolan',
      colorSeed: 8,
      category: MovieCategory.trending,
      castIds: ['a6', 'a10', 'a2'],
      tmdbId: 157336,
    ),
    Movie(
      id: 'm10',
      title: 'Dunkirk',
      tagline: 'Survival is victory.',
      genre: 'War',
      year: 2017,
      durationMinutes: 106,
      rating: 7.8,
      description: 'Told across land, sea, and air, this account of the WWII '
          'evacuation of Allied soldiers from the beaches of Dunkirk '
          'follows the soldiers and civilians caught in the desperate escape.',
      director: 'Christopher Nolan',
      colorSeed: 9,
      category: MovieCategory.trending,
      castIds: ['a4', 'a3'],
      tmdbId: 374720,
    ),
    Movie(
      id: 'm11',
      title: 'Tenet',
      tagline: 'Time doesn\'t give second chances. He gives his own.',
      genre: 'Sci-Fi',
      year: 2020,
      durationMinutes: 150,
      rating: 7.3,
      description: 'Armed with only one word and the ability to manipulate the '
          'flow of time itself, a secret agent races to prevent an attack '
          'that threatens the entire world.',
      director: 'Christopher Nolan',
      colorSeed: 10,
      category: MovieCategory.newRelease,
      castIds: ['a8', 'a9', 'a2'],
      tmdbId: 577922,
    ),
    Movie(
      id: 'm12',
      title: 'Oppenheimer',
      tagline: 'The world forever changes.',
      genre: 'Biography',
      year: 2023,
      durationMinutes: 180,
      rating: 8.3,
      description: 'The story of J. Robert Oppenheimer, the physicist whose '
          'leadership of the Manhattan Project brought the atomic bomb '
          'into existence and forever changed the course of history.',
      director: 'Christopher Nolan',
      colorSeed: 11,
      category: MovieCategory.trending,
      castIds: ['a3', 'a16'],
      tmdbId: 872585,
    ),
  ];

  List<Movie> getAll() => List.unmodifiable(_movies);

  List<Movie> getByCategory(MovieCategory category) =>
      _movies.where((m) => m.category == category).toList();

  Movie? getMovieById(String id) {
    try {
      return _movies.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  Actor? getActorById(String id) {
    try {
      return _actors.firstWhere((a) => a.actorId == id);
    } catch (_) {
      return null;
    }
  }

  List<Actor> getActorsByIds(List<String> ids) =>
      ids.map(getActorById).whereType<Actor>().toList();

  List<Movie> search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];
    return _movies
        .where((m) =>
            m.title.toLowerCase().contains(q) ||
            m.genre.toLowerCase().contains(q))
        .toList();
  }
}
