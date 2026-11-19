import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';

const Movie testMovie = Movie(
  id: 'nosferatu',
  title: 'Nosferatu',
  synopsis: 'A gothic tale.',
  ageRating: '18',
  screeningTime: 'Sunday 18 Oct 2026, 14:00',
  ticketPrice: 8.00,
  posterPath: 'assets/images/nosferatu.jpg',
);

void main() {
  test('BasketItem stores the film and the number of tickets', () {
    const BasketItem item = BasketItem(movie: testMovie, quantity: 3);

    expect(item.movie, testMovie);
    expect(item.quantity, 3);
  });

  test('lineTotal multiplies the ticket price by the quantity', () {
    const BasketItem item = BasketItem(movie: testMovie, quantity: 3);

    expect(item.lineTotal, 24.00);
  });
}
