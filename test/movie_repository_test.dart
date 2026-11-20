import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MovieRepository unit tests', () {
    test('loadMoviesFromAsset reads every film from movies.json', () async {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = await repository.loadMoviesFromAsset();

      expect(movies.length, 3);
      expect(movies[0].id, 'nosferatu');
      expect(movies[1].id, 'get-out');
      expect(movies[2].id, 'coraline');
      expect(movies[2].ticketPrice, 5.00);
      expect(movies[2].posterPath, 'assets/images/coraline.jpg');
      expect(repository.getMovies(), movies);
    });

    test('getMovies returns three movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 3);
    });

    test('getMovies contains the correct film details', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie first = movies[0];
      expect(first.id, 'nosferatu');
      expect(first.title, 'Nosferatu');
      expect(first.ticketPrice, 8.00);
      expect(first.posterPath, isNotEmpty);

      final Movie second = movies[1];
      expect(second.id, 'get-out');
      expect(second.title, 'Get Out');
      expect(second.ticketPrice, 6.50);
      expect(second.posterPath, isNotEmpty);
    });

    test('getMovieById returns the matching movie when the id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('nosferatu');

      expect(movie, isNotNull);
      expect(movie?.title, 'Nosferatu');
      expect(movie?.ticketPrice, 8.00);
    });

    test('getMovieById returns null when the id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });
  });
}
