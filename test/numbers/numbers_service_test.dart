import 'dart:io';

import 'package:messagebird/numbers.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('NumbersService', () {
    NumbersService numbersService;

    setUp(() {
      numbersService = ApiNumbersService(credentials.API_TEST_KEY);
    });

    test('should get numbers object', () {
      numbersService.list().then((numbers) {
        expect(numbers, isA<Numbers>());
      });
    });

    test('should return valid properties for list endpoint', () {
      numbersService.list().then((numbers) {
        expect(numbers.offset, isA<int>());
        expect(numbers.limit, isA<int>());
        expect(numbers.count, isA<int>());
        expect(numbers.totalCount, isA<int>());
        expect(numbers.items, isA<List<PhoneNumber>>());
      });
    });

    test('should return valid properties for read endpoint', () {
      const String number = '31612345670';

      numbersService.read(number).then((phoneNumber) {
        expect(phoneNumber.number, equals(number));
        expect(phoneNumber, isA<PhoneNumber>());
      });
    });

    test('should return valid properties for update endpoint', () {
      const String number = '31612345670';
      final List<String> tags = ['tag1'];

      numbersService.update(number, tags).then((phoneNumber) {
        expect(phoneNumber.number, equals(number));
        expect(phoneNumber.tags, equals(tags));
        expect(phoneNumber, isA<PhoneNumber>());
      });
    });
    test('should return valid properties for search endpoint', () {
      numbersService
          .search('NL',
              number: '23',
              features: ['sms', 'voice'],
              type: 'mobile',
              limit: 5)
          .then((numbers) {
        expect(numbers.limit, equals(5));
        expect(numbers, isA<Numbers>());
      });
    });
  }, skip: !credentials.arePresent);
}
