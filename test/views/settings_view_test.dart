import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('SettingsView displays the profile fields and switch',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('My Settings'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('SAVE SETTINGS'), findsOneWidget);
  });

  testWidgets('Toggling the switch and saving settings updates state',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

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
    await tester.pumpAndSettle();

    expect(find.text('Settings saved for alex@example.com'), findsOneWidget);

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    expect(await prefs.getString(prefAddress), '10 Example Road, Southsea');
    expect(await prefs.getString(prefEmail), 'alex@example.com');
    expect(await prefs.getString(prefPatronNumber), '1234');
    expect(await prefs.getBool(prefEmailNews), isTrue);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();
    expect(find.text('10 Example Road, Southsea'), findsOneWidget);
    expect(find.text('alex@example.com'), findsOneWidget);
    expect(find.text('1234'), findsOneWidget);
    final Switch reopenedSwitch = tester.widget<Switch>(find.byType(Switch));
    expect(reopenedSwitch.value, isTrue);
  });

  testWidgets('SettingsView pre-fills saved settings on open',
      (WidgetTester tester) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefAddress: '22 Sample Street, Portsmouth',
      prefEmail: 'sam@example.com',
      prefPatronNumber: '5678',
      prefEmailNews: true,
    });

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('22 Sample Street, Portsmouth'), findsOneWidget);
    expect(find.text('sam@example.com'), findsOneWidget);
    expect(find.text('5678'), findsOneWidget);
    final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isTrue);
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
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Email Address'),
      'alex@example.com',
    );
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsView), findsNothing);
    expect(find.text('Home page'), findsOneWidget);
    expect(await SharedPreferencesAsync().getString(prefEmail), isNull);
  });
}
