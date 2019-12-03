import 'dart:io';

import 'package:messagebird/balance.dart';

void main() {
  final BalanceService balanceService = ApiBalanceService('YOUR_KEY_HERE');
  balanceService
      .read()
      .then((balance) => stdout.write('My balance is ${balance.amount}'));
}
