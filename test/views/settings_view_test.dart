import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  testWidgets('SettingsView displays the profile fields and switch',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    expect(find.text('My Settings'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('SAVE SETTINGS'), findsOneWidget);
  });

  testWidgets('Toggling the switch and saving settings updates state',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    final Finder addressField = find.widgetWithText(TextField, 'Address');
    final Finder emailField = find.widgetWithText(TextField, 'Email Address');
    final Finder patronField = find.widgetWithText(TextField, 'Patron Number');

    await tester.enterText(addressField, '10 Example Road, Southsea');
    await tester.enterText(emailField, 'alex@example.com');
    await tester.enterText(patronField, '1234');

    final Finder switchFinder = find.byType(Switch);
    expect(tester.widget<Switch>(switchFinder).value, isFalse);
    await tester.tap(switchFinder);
    await tester.pump();
    expect(tester.widget<Switch>(switchFinder).value, isTrue);

    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pump();

    expect(find.text('Settings saved for alex@example.com'), findsOneWidget);
  });

  testWidgets('CANCEL closes the settings page', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: '/settings',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) {
            return const Text('Home page');
          },
          '/settings': (BuildContext context) {
            return const SettingsView();
          },
        },
      ),
    );

    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsView), findsNothing);
    expect(find.text('Home page'), findsOneWidget);
  });
}
