import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

const Movie nosferatu = Movie(
  id: 'nosferatu',
  title: 'Nosferatu',
  synopsis: 'A gothic tale.',
  ageRating: '18',
  screeningTime: 'Sunday 18 Oct 2026, 14:00',
  ticketPrice: 8.00,
  posterPath: 'assets/images/nosferatu.jpg',
);

const Movie coraline = Movie(
  id: 'coraline',
  title: 'Coraline',
  synopsis: 'A curious girl finds a secret door.',
  ageRating: 'PG',
  screeningTime: 'Sunday 25 Oct 2026, 11:00',
  ticketPrice: 5.00,
  posterPath: 'assets/images/coraline.jpg',
);

void main() {
  final BasketRepository basket = BasketRepository.instance;

  setUp(() {
    basket.clear();
  });

  group('BasketRepository', () {
    test('starts empty with no service charge', () {
      expect(basket.getItems(), isEmpty);
      expect(basket.getServiceCharge(), 0.0);
      expect(basket.getTotal(), 0.0);
    });

    test('adds tickets and adds one service charge to the total', () {
      basket.addItem(const BasketItem(movie: nosferatu, quantity: 2));
      basket.addItem(const BasketItem(movie: coraline, quantity: 1));

      expect(basket.getItems().length, 2);
      expect(basket.getItems()[0].movie.id, 'nosferatu');
      expect(basket.getItems()[1].movie.id, 'coraline');
      expect(basket.getServiceCharge(), 4.00);
      expect(basket.getTotal(), 25.00);
    });

    test('removeItem removes only the chosen line', () {
      basket.addItem(const BasketItem(movie: nosferatu, quantity: 2));
      basket.addItem(const BasketItem(movie: coraline, quantity: 1));

      basket.removeItem(0);

      expect(basket.getItems().length, 1);
      expect(basket.getItems()[0].movie.id, 'coraline');
      expect(basket.getTotal(), 9.00);
    });

    test('clear empties the basket', () {
      basket.addItem(const BasketItem(movie: nosferatu, quantity: 2));

      basket.clear();

      expect(basket.getItems(), isEmpty);
      expect(basket.getTotal(), 0.0);
    });

    test('getItems returns a copy that cannot change the basket', () {
      basket.addItem(const BasketItem(movie: nosferatu, quantity: 1));

      expect(
        () {
          basket.getItems().add(const BasketItem(movie: coraline, quantity: 1));
        },
        throwsUnsupportedError,
      );
      expect(basket.getItems().length, 1);
    });
  });
  test('removeItem ignores an index outside the basket', () {
    basket.addItem(const BasketItem(movie: nosferatu, quantity: 2));

    basket.removeItem(5);
    basket.removeItem(-1);

    expect(basket.getItems().length, 1);
    expect(basket.getItems()[0].movie.id, 'nosferatu');
  });
}
