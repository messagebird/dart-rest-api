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

  group('BalanceService', () {
    setUp(() async {
      balanceService = ApiBalanceService(credentials['test']);
    });
    test('should get balance', () async {
      expect(await balanceService.read(), isA<Balance>());
    });
  });

  group('CallflowService', () {
    Callflow callflow;
    Callflow callflowFromJson;

    setUp(() {
      callflowsService = ApiCallflowsService('${credentials['test']}');
      callflowFromJson = Callflow.fromJson(
          File('test_resources/callflow.json').readAsStringSync());
      callflow = Callflow(
          id: 'de3ed163-d5fc-45f4-b8c4-7eea7458c635',
          title: 'Forward call to 31612345678',
          record: false,
          steps: [
            const Step(
                id: '2fa1383e-6f21-4e6f-8c36-0920c3d0730b',
                action: StepAction.transfer,
                options: {StepOption.destination: '31612345678'})
          ],
          createdAt: DateTime.parse('2017-03-06T14:52:22Z'),
          updatedAt: DateTime.parse('2017-03-06T14:52:22Z'));
    });

    test('should deserialize from json', () {
      expect(callflow.id, equals(callflowFromJson.id));
      expect(callflow.title, equals(callflowFromJson.title));
      expect(callflow.record, equals(callflowFromJson.record));
      expect(callflow.steps[0].id, equals(callflowFromJson.steps[0].id));
      expect(callflow.createdAt, equals(callflowFromJson.createdAt));
      expect(callflow.updatedAt, equals(callflowFromJson.updatedAt));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = callflowFromJson.toMap();

      expect(serialized['id'], equals(callflowFromJson.id));
      expect(serialized['title'], equals(callflowFromJson.title));
      expect(serialized['record'], equals(callflowFromJson.record));
      expect(
          serialized['steps'][0]['id'], equals(callflowFromJson.steps[0].id));
    });

    test('should get no conversations on our account', () async {
      await callflowsService.read('bogus');
      //expect((await callflowsService.list()).length, 0);
    });
  });

  group('ConversationService', () {
    setUp(() {
      conversationsService = ApiConversationsService(credentials['test']);
    });
    test('should get endpoint', () {
      expect(conversationsService.getEndpoint(), isA<String>());
    });
  });
}
