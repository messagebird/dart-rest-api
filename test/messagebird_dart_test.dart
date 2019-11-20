import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/balance/api_balance_service.dart';
import 'package:messagebird_dart/src/balance/balance_service.dart';
import 'package:messagebird_dart/src/balance/model/balance.dart';
import 'package:messagebird_dart/src/callflows/model/callflow.dart';
import 'package:messagebird_dart/src/callflows/model/callflows.dart';
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
      source = '''{
          "data": [
            {
              "id": "de3ed163-d5fc-45f4-b8c4-7eea7458c635",
              "title": "Forward call to 31612345678",
              "record": true,
              "steps": [
                {
                  "id": "2fa1383e-6f21-4e6f-8c36-0920c3d0730b"
                }
              ],
              "createdAt": "2017-03-06T14:52:22Z",
              "updatedAt": "2017-03-06T14:52:22Z"
            }
          ],
          "_links": {
            "self": "/call-flows/de3ed163-d5fc-45f4-b8c4-7eea7458c635"
          }
        }''';
      callflowsService = ApiCallflowsService(credentials['test']);
      callflowFromJson = Callflows.fromJson(json.decode(source)).callflows[0];
      callflow = Callflow(
          id: 'de3ed163-d5fc-45f4-b8c4-7eea7458c635',
          title: 'Forward call to 31612345678',
          record: true,
          steps: [
            Step(
                id: '2fa1383e-6f21-4e6f-8c36-0920c3d0730b',
                action: Action.transfer,
                options: {Option.destination: '31612345678'})
          ],
          createdAt: DateTime.parse('2017-03-06T14:52:22Z'),
          updatedAt: DateTime.parse('2017-03-06T14:52:22Z'));
    });
    test('Does parse callflows', () {
      expect(callflow.id, equals(callflowFromJson.id));
      expect(callflow.title, equals(callflowFromJson.title));
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
