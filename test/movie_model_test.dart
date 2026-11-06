import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('creates Movie instance with given properties', () {
      const movie = Movie(
        id: 'test-film',
        title: 'Test Film',
        synopsis: 'A film used for testing.',
        ageRating: '12A',
        screeningTime: 'Monday 19 Oct 2026, 18:00',
        ticketPrice: 7.25,
        posterPath: 'assets/images/nosferatu.jpg',
      );

      expect(movie.id, 'test-film');
      expect(movie.title, 'Test Film');
      expect(movie.synopsis, 'A film used for testing.');
      expect(movie.ageRating, '12A');
      expect(movie.screeningTime, 'Monday 19 Oct 2026, 18:00');
      expect(movie.ticketPrice, 7.25);
      expect(movie.posterPath, 'assets/images/nosferatu.jpg');
    });

    test('formattedPrice adds two decimal places to a whole-pound price', () {
      const movie = Movie(
        id: 'test-film',
        title: 'Test Film',
        synopsis: 'A film used for testing.',
        ageRating: '12A',
        screeningTime: 'Monday 19 Oct 2026, 18:00',
        ticketPrice: 8,
        posterPath: 'assets/images/nosferatu.jpg',
      );

      expect(movie.formattedPrice, '£8.00');
    });

    test('formattedPrice keeps two decimal places for a price with pence', () {
      const movie = Movie(
        id: 'test-film',
        title: 'Test Film',
        synopsis: 'A film used for testing.',
        ageRating: '12A',
        screeningTime: 'Monday 19 Oct 2026, 18:00',
        ticketPrice: 6.5,
        posterPath: 'assets/images/nosferatu.jpg',
      );

      expect(movie.formattedPrice, '£6.50');
    });
  });
}
