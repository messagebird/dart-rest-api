import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('BalanceService', () {
    Map credentials;
    BalanceService balanceService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      balanceService = ApiBalanceService(credentials['test']);
    });

    test('should get balance object', () {
      balanceService.read().then((balance) {
        expect(balance, isA<Balance>());
      });
    });

    test('should return valid properties ', () {
      balanceService.read().then((balance) {
        expect(balance.amount, isA<double>());
        expect(balance.payment, isIn(Payment.values));
        expect(balance.type, isA<String>());
      });
    });
  });
}
