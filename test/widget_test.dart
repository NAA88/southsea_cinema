import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
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
  });
}
