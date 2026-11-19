import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {
  test('UserSettings defaults to empty values and no email news', () {
    const UserSettings settings = UserSettings();
    expect(settings.address, isEmpty);
    expect(settings.email, isEmpty);
    expect(settings.patronNumber, isEmpty);
    expect(settings.receiveEmailNews, isFalse);
  });

  test('UserSettings stores configured values', () {
    const UserSettings settings = UserSettings(
      address: '10 Example Road, Southsea',
      email: 'alex@example.com',
      patronNumber: '1234',
      receiveEmailNews: true,
    );
    expect(settings.address, '10 Example Road, Southsea');
    expect(settings.email, 'alex@example.com');
    expect(settings.patronNumber, '1234');
    expect(settings.receiveEmailNews, isTrue);
  });
}
