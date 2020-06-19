import 'dart:io';

import 'package:messagebird/balance.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  group('BalanceService', () {
    Credentials credentials;
    BalanceService balanceService;

    setUp(() {
      credentials = Credentials.from(Platform.environment);
      balanceService = ApiBalanceService(credentials.API_TEST_KEY);
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
