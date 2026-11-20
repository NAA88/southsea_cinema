import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';
import 'package:flutter/services.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });

  group('Southsea Cinema app tests', () {
    testWidgets('home page shows its title, movie cards and booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text('Southsea Cinema'), findsOneWidget);
      expect(find.byType(MovieCard), findsWidgets);
      expect(find.text('NOSFERATU'), findsOneWidget);
      expect(find.text('BOOK TICKETS'), findsWidgets);
    });

    testWidgets('Tapping BOOK TICKETS opens the page for that film',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.widgetWithText(CinemaButton, 'BOOK TICKETS').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('NOSFERATU (18)'), findsOneWidget);
    });

    testWidgets('The drawer lists every page and closes with its X button',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('My Basket'), findsOneWidget);
      expect(find.text('My Settings'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(NavDrawer), findsNothing);
    });

    testWidgets('My Basket in the drawer opens the basket page',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('My Basket'));
      await tester.pumpAndSettle();

      expect(find.byType(BasketView), findsOneWidget);
    });

    testWidgets('My Settings in the drawer opens the settings page',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('My Settings'));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsView), findsOneWidget);
    });
  });
}
