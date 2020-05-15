import 'dart:convert';
import 'dart:io';

import 'package:messagebird/numbers.dart';
import 'package:test/test.dart';

void main() {
  group('NumbersService', () {
    Map credentials;
    NumbersService numbersService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      numbersService = ApiNumbersService(credentials['test']);
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
      final String number = '31612345670';

      numbersService.read(number).then((phoneNumber) {
        expect(phoneNumber.number, equals(number));
        expect(phoneNumber, isA<PhoneNumber>());
      });
    });

    test('should return valid properties for update endpoint', () {
      final String number = '31612345670';
      final List<String> tags = ['tag1'];

      numbersService.update(number, tags).then((phoneNumber) {
        expect(phoneNumber.number, equals(number));
        expect(phoneNumber.tags, equals(tags));
        expect(phoneNumber, isA<PhoneNumber>());
      });
    });
  });
}
