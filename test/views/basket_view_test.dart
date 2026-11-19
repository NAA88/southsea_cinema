import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

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
  setUp(() {
    BasketRepository.instance.clear();
  });

  testWidgets('BasketView displays empty message when basket has no tickets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('BUY TICKETS'), findsNothing);
  });

  testWidgets('BasketView lists tickets with the service charge and total',
      (WidgetTester tester) async {
    BasketRepository.instance.addItem(
      const BasketItem(movie: nosferatu, quantity: 2),
    );
    BasketRepository.instance.addItem(
      const BasketItem(movie: coraline, quantity: 1),
    );

    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('MY ORDER'), findsOneWidget);
    expect(find.text('2 Tickets'), findsOneWidget);
    expect(
      find.text(
        '2 Standard\nNOSFERATU, Sunday 18 Oct 2026, 14:00, '
        'Southsea Cinema Room',
      ),
      findsOneWidget,
    );
    expect(find.text('£16.00'), findsOneWidget);
    expect(find.text('1 Ticket'), findsOneWidget);
    expect(find.text('£5.00'), findsOneWidget);
    expect(find.text('£4.00'), findsOneWidget);
    expect(find.text('£25.00'), findsOneWidget);
    expect(find.text('BUY TICKETS'), findsOneWidget);
  });

  testWidgets('Deleting the second line keeps the first',
      (WidgetTester tester) async {
    BasketRepository.instance.addItem(
      const BasketItem(movie: nosferatu, quantity: 2),
    );
    BasketRepository.instance.addItem(
      const BasketItem(movie: coraline, quantity: 1),
    );
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    await tester.tap(find.byIcon(Icons.delete_outline).last);
    await tester.pump();

    expect(find.text('1 Ticket'), findsNothing);
    expect(find.text('2 Tickets'), findsOneWidget);
    expect(find.text('£20.00'), findsOneWidget);
    expect(BasketRepository.instance.getItems().length, 1);
    expect(BasketRepository.instance.getItems()[0].movie.id, 'nosferatu');
  });

  testWidgets('BUY TICKETS empties the basket and thanks the customer',
      (WidgetTester tester) async {
    BasketRepository.instance.addItem(
      const BasketItem(movie: nosferatu, quantity: 2),
    );
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    await tester.tap(find.text('BUY TICKETS'));
    await tester.pump();

    expect(BasketRepository.instance.getItems(), isEmpty);
    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('Thank you, your tickets are booked.'), findsOneWidget);
  });
}
