import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';

void main() {
  testWidgets('CinemaButton shows its label and runs onPressed when tapped',
      (WidgetTester tester) async {
    int pressCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CinemaButton(
            label: 'BOOK TICKETS',
            onPressed: () {
              pressCount++;
            },
          ),
        ),
      ),
    );

    expect(find.text('BOOK TICKETS'), findsOneWidget);
    await tester.tap(find.byType(CinemaButton));
    expect(pressCount, 1);
  });

  testWidgets('CinemaButton has square corners', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CinemaButton(label: 'SAVE', onPressed: () {}),
        ),
      ),
    );

    final ElevatedButton button = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );
    final OutlinedBorder? shape = button.style?.shape?.resolve(
      <WidgetState>{},
    );
    expect(
      shape,
      const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    );
  });
}
