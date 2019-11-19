import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/balance/api_balance_service.dart';
import 'package:messagebird_dart/src/balance/balance_service.dart';
import 'package:messagebird_dart/src/conversations/api_conversations_service.dart';
import 'package:messagebird_dart/src/conversations/conversations_service.dart';
import 'package:test/test.dart';

void main() {
  ConversationsService conversationsService;
  BalanceService balanceService;
  Map credentials;

  setUp(() async {
    credentials =
        json.decode(File('test_resources/keys.json').readAsStringSync());
  });

  group('balance', () {
    setUp(() async {
      balanceService = ApiBalanceService(credentials['test']);
    });
    test('Gets balance', () async {
      final int result =
          json.decode((await balanceService.read()).body)['amount'];
      expect(result, isA<int>());
    });
  });

  group('conversations', () {
    setUp(() async {
      conversationsService = ApiConversationsService(credentials['test']);
    });
    test('Endpoint is set', () {
      expect(conversationsService.getEndpoint(), isA<String>());
    });
  });
}
