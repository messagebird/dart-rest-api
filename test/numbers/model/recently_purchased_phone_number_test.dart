import 'dart:io';

import 'package:messagebird/numbers.dart';
import 'package:test/test.dart';

void main() {
  group('RecentlyPurchasedPhoneNumber', () {
    test('should deserialize from json', () {
      final RecentlyPurchasedPhoneNumber phoneNumber =
          RecentlyPurchasedPhoneNumber.fromJson(
              File('test_resources/recently_purchased_phone_number.json')
                  .readAsStringSync());

      expect(phoneNumber.country, equals('NL'));
      expect(phoneNumber.createdAt,
          equals(DateTime.parse('2019-04-25T14:04:04Z')));
      expect(phoneNumber.features.length, equals(2));
      expect(phoneNumber.features[0], equals(Feature.sms));
      expect(phoneNumber.features[1], equals(Feature.voice));
      expect(phoneNumber.locality, equals('Haarlem'));
      expect(phoneNumber.number, equals('31971234567'));
      expect(phoneNumber.region, equals('Haarlem'));
      expect(phoneNumber.renewalAt,
          equals(DateTime.parse('2019-05-25T00:00:00Z')));
      expect(phoneNumber.status, equals('active'));
      expect(phoneNumber.tags, equals([]));
      expect(phoneNumber.type, equals(PhoneNumberType.landline));
    });
  });
}
