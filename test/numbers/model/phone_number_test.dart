import 'dart:io';

import 'package:messagebird/numbers.dart';
import 'package:test/test.dart';

void main() {
  group('PhoneNumber', () {
    test('should deserialize from json', () {
      final PhoneNumber phoneNumber = PhoneNumber.fromJson(
          File('test_resources/phone_number.json').readAsStringSync());

      expect(phoneNumber.number, equals('31612345670'));
      expect(phoneNumber.country, equals('NL'));
      expect(phoneNumber.region, equals('Texel'));
      expect(phoneNumber.locality, equals('Texel'));
      expect(phoneNumber.features.length, equals(2));
      expect(phoneNumber.features[0], equals('sms'));
      expect(phoneNumber.features[1], equals('voice'));
      expect(phoneNumber.tags.length, equals(0));
      expect(phoneNumber.type, equals('mobile'));
      expect(phoneNumber.status, equals('active'));
    });
  });
}
