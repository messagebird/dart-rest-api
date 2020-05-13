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

    test('should return valid properties ', () {
      numbersService.list().then((numbers) {
        expect(numbers.offset, isA<int>());
        expect(numbers.limit, isA<int>());
        expect(numbers.count, isA<int>());
        expect(numbers.totalCount, isA<int>());
        expect(numbers.items, isA<List<PhoneNumber>>());
      });
    });
  });
}
