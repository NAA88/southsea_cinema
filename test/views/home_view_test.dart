import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });

  testWidgets('HomeView shows a loading indicator, then the films from JSON',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeView()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(MovieCard), findsWidgets);
    expect(find.text('NOSFERATU'), findsOneWidget);
  });

  testWidgets('HomeView shows a message when the films cannot load',
      (WidgetTester tester) async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      return null;
    });
    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', null);
    });

    await tester.pumpWidget(const MaterialApp(home: HomeView()));
    await tester.pumpAndSettle();

    expect(find.textContaining('Could not load the films'), findsOneWidget);
    expect(find.byType(MovieCard), findsNothing);
  });
}
