import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/balance/model/balance.dart';
import 'package:test/test.dart';

void main() {
  group('BalanceService', () {
    Map credentials;
    BalanceService balanceService;
    Balance balance;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      balanceService = ApiBalanceService(credentials['test']);
    });

    test('should get balance object', () async {
      balance = await balanceService.read();
      expect(balance, isA<Balance>());
    });

    test('should return valid properties ', () {
      expect(balance.amount, isA<double>());
      expect(balance.payment, isIn(Payment.values));
      expect(balance.type, isA<String>());
    });
  });
}
