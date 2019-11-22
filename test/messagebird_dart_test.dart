import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/balance/api_balance_service.dart';
import 'package:messagebird_dart/src/balance/balance_service.dart';
import 'package:messagebird_dart/src/balance/model/balance.dart';
import 'package:messagebird_dart/src/callflows/model/callflow.dart';
import 'package:messagebird_dart/src/callflows/model/step.dart';
import 'package:messagebird_dart/src/conversations/api_conversations_service.dart';
import 'package:messagebird_dart/src/conversations/conversations_service.dart';
import 'package:test/test.dart';

void main() {
  ConversationsService conversationsService;
  BalanceService balanceService;
  CallflowsService callflowsService;
  Map credentials;

  setUp(() async {
    credentials =
        json.decode(File('test_resources/keys.json').readAsStringSync());
  });

  group('balance', () {
    setUp(() async {
      balanceService = ApiBalanceService(credentials['test']);
    });
    test('Balance getter', () async {
      expect(await balanceService.read(), isA<Balance>());
    });
  });

  group('callflows', () {
    Callflow callflow;
    Callflow callflowFromJson;

    setUp(() async {
      callflowsService = ApiCallflowsService(credentials['test']);
      callflowFromJson = Callflow.fromJson(
          File('test_resources/callflow.json').readAsStringSync());
      callflow = Callflow(
          id: 'de3ed163-d5fc-45f4-b8c4-7eea7458c635',
          title: 'Forward call to 31612345678',
          record: false,
          steps: [
            Step(
                id: '2fa1383e-6f21-4e6f-8c36-0920c3d0730b',
                action: StepAction.transfer,
                options: {StepOption.destination: '31612345678'})
          ],
          createdAt: DateTime.parse('2017-03-06T14:52:22Z'),
          updatedAt: DateTime.parse('2017-03-06T14:52:22Z'));
    });

    test('Callflow deserialization', () {
      expect(callflow.id, equals(callflowFromJson.id));
      expect(callflow.title, equals(callflowFromJson.title));
      expect(callflow.record, equals(callflowFromJson.record));
      expect(callflow.steps[0].id, equals(callflowFromJson.steps[0].id));
      expect(callflow.createdAt, equals(callflowFromJson.createdAt));
      expect(callflow.updatedAt, equals(callflowFromJson.updatedAt));
    });

    test('Callflow serialization', () {
      final Map<String, dynamic> serialized = callflowFromJson.toMap();

      expect(serialized['id'], equals(callflowFromJson.id));
      expect(serialized['title'], equals(callflowFromJson.title));
      expect(serialized['record'], equals(callflowFromJson.record));
      expect(
          serialized['steps'][0]['id'], equals(callflowFromJson.steps[0].id));
    });
  });

  group('conversations', () {
    setUp(() async {
      conversationsService = ApiConversationsService(credentials['test']);
    });
    test('Endpoint getter', () {
      expect(conversationsService.getEndpoint(), isA<String>());
    });
  });
}
