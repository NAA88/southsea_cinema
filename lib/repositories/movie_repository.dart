import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    //method that returns a list where every item is a Movie
    return const [
      Movie(
        id: 'nosferatu',
        title: 'Nosferatu',
        synopsis: 'A gothic tale of obsession between a haunted young woman '
            'and the terrifying vampire infatuated with her.',
        ageRating: '18',
        screeningTime: 'Sunday 18 Oct 2026, 14:00',
        ticketPrice: 8.00,
        posterPath: 'assets/images/nosferatu.jpg',
      ),
      Movie(
        id: 'get-out',
        title: 'Get Out',
        synopsis: 'A young man visits the family estate of his girlfriend '
            'and uncovers a disturbing secret.',
        ageRating: '15',
        screeningTime: 'Saturday 24 Oct 2026, 19:30',
        ticketPrice: 6.50,
        posterPath: 'assets/images/get_out.jpg',
      ),
      Movie(
        id: 'coraline',
        title: 'Coraline',
        synopsis: 'A curious girl finds a secret door to a world that seems '
            'better than her own, until she learns what it really wants.',
        ageRating: 'PG',
        screeningTime: 'Sunday 25 Oct 2026, 11:00',
        ticketPrice: 5.00,
        posterPath: 'assets/images/coraline.jpg',
      ),
    ];
  }
}
