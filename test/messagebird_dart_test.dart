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
    test('Gets balance', () async {
      expect(await balanceService.read(), isA<Balance>());
    });
  });

  group('callflows', () {
    Callflow callflow;
    Callflow callflowFromJson;
    String source;

    setUp(() async {
      callflowsService = ApiCallflowsService(credentials['test']);

      source = '''{
          "data": [
            {
              "id": "de3ed163-d5fc-45f4-b8c4-7eea7458c635",
              "title": "Forward call to 31612345678",
              "record": false,
              "steps": [
                {
                  "id": "2fa1383e-6f21-4e6f-8c36-0920c3d0730b"
                }
              ],
              "default": false,
              "createdAt": "2017-03-06T14:52:22Z",
              "updatedAt": "2017-03-06T14:52:22Z"
            }
          ],
          "_links": {
            "self": "/call-flows/de3ed163-d5fc-45f4-b8c4-7eea7458c635"
          }
        }''';

      callflow = Callflow(
          id: 'de3ed163-d5fc-45f4-b8c4-7eea7458c635',
          title: 'Forward call to 31612345678',
          record: false,
          steps: [
            Step(
                id: '2fa1383e-6f21-4e6f-8c36-0920c3d0730b',
                action: Action.transfer,
                options: {Option.destination: '31612345678'})
          ],
          createdAt: DateTime.parse('2017-03-06T14:52:22Z'),
          updatedAt: DateTime.parse('2017-03-06T14:52:22Z'));
    });

    test('Deserialize callflows from json', () {
      callflowFromJson = Callflow.fromJsonList(json.decode(source)['data'])[0];

      expect(callflow.id, equals(callflowFromJson.id));
      expect(callflow.title, equals(callflowFromJson.title));
      expect(callflow.record, equals(callflowFromJson.record));
      expect(callflow.steps[0].id, equals(callflowFromJson.steps[0].id));
      expect(callflow.createdAt, equals(callflowFromJson.createdAt));
      expect(callflow.updatedAt, equals(callflowFromJson.updatedAt));
    });

    test('Serialize callflows to json objects', () {
      callflowFromJson = Callflow.fromJsonList(json.decode(source)['data'])[0];
      final Map<String, dynamic> serialized = callflowFromJson.toJson();

      expect(serialized['id'], equals(json.decode(source)['data'][0]['id']));
      expect(
          serialized['title'], equals(json.decode(source)['data'][0]['title']));
      expect(serialized['record'],
          equals(json.decode(source)['data'][0]['record']));
      expect(serialized['steps'][0]['id'],
          equals(json.decode(source)['data'][0]['steps'][0]['id']));
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
