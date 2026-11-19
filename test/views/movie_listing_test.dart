import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

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
  setUp(() {
    BasketRepository.instance.clear();
  });

  testWidgets('MovieListing shows the film details and one ticket',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MovieListing(movie: testMovie)),
    );

    expect(find.text('NOSFERATU (18)'), findsOneWidget);
    expect(find.text('Southsea Cinema Room'), findsOneWidget);
    expect(find.text('Sunday 18 Oct 2026, 14:00'), findsOneWidget);
    expect(find.text('Tickets (£8.00 each)'), findsOneWidget);
    expect(find.text('Tickets selected: 1'), findsOneWidget);
    expect(find.text('ADD TO ORDER'), findsOneWidget);
  });

  testWidgets('Adding one ticket puts it in the basket',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MovieListing(movie: testMovie)),
    );

    await tester.ensureVisible(find.text('ADD TO ORDER'));
    await tester.tap(find.text('ADD TO ORDER'));
    await tester.pump();

    final List<BasketItem> items = BasketRepository.instance.getItems();
    expect(items.length, 1);
    expect(items[0].movie.id, 'nosferatu');
    expect(items[0].quantity, 1);
    expect(
      find.text('Added 1 ticket for Nosferatu to your order.'),
      findsOneWidget,
    );
  });

  testWidgets('Choosing three tickets adds all three to the basket',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MovieListing(movie: testMovie)),
    );

    await tester.tap(find.byType(DropdownMenu<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3').last);
    await tester.pumpAndSettle();
    expect(find.text('Tickets selected: 3'), findsOneWidget);

    await tester.ensureVisible(find.text('ADD TO ORDER'));
    await tester.tap(find.text('ADD TO ORDER'));
    await tester.pump();

    final List<BasketItem> items = BasketRepository.instance.getItems();
    expect(items.length, 1);
    expect(items[0].quantity, 3);
    expect(
      find.text('Added 3 tickets for Nosferatu to your order.'),
      findsOneWidget,
    );
  });
}
