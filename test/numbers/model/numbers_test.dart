import 'dart:io';

import 'package:messagebird/numbers.dart';
import 'package:test/test.dart';

void main() {
  group('Numbers', () {
    test('should deserialize from json', () {
      final Numbers numbers = Numbers.fromJson(
          File('test_resources/numbers.json').readAsStringSync());

      expect(numbers.offset, equals(0));
      expect(numbers.limit, equals(20));
      expect(numbers.count, equals(1));
      expect(numbers.totalCount, equals(1));
      expect(numbers.items.length, equals(1));
      expect(numbers.items[0].number, equals('31612345670'));
      expect(numbers.items[0].country, equals('NL'));
      expect(numbers.items[0].region, equals('Texel'));
      expect(numbers.items[0].locality, equals('Texel'));
      expect(numbers.items[0].features.length, equals(2));
      expect(numbers.items[0].features[0], equals(Feature.sms));
      expect(numbers.items[0].features[1], equals(Feature.voice));
      expect(numbers.items[0].tags.length, equals(0));
      expect(numbers.items[0].type, equals(PhoneNumberType.mobile));
      expect(numbers.items[0].status, equals('active'));
    });
  });
}
