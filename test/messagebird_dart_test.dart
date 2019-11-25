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
import 'package:messagebird_dart/src/conversations/model/conversation_message.dart';
import 'package:messagebird_dart/src/general/model/content.dart';
import 'package:messagebird_dart/src/general/model/message.dart';
import 'package:test/test.dart';

void main() {
  Map credentials;
  BalanceService balanceService;
  CallflowsService callflowsService;
  ConversationsService conversationsService;

  setUp(() async {
    credentials =
        json.decode(File('test_resources/keys.json').readAsStringSync());
  });

  group('BalanceService', () {
    /// Available methods:\
    ///
    /// GET /balance
    Balance balance;

    setUp(() async {
      balanceService = ApiBalanceService(credentials['test']);
      balance = await balanceService.read();
    });

    test('should get balance object', () {
      expect(balance, isA<Balance>());
    });

    test('should return valid properties ', () {
      expect(balance.amount, isA<double>());
      expect(balance.payment, isIn(Payment.values));
      expect(balance.type, isA<String>());
    });
  });

  group('CallflowService', () {
    /// Available methods:
    ///
    /// GET /call-flows/
    /// GET /call-flows/{id}
    /// POST /call-flows/
    /// PUT /call-flows/{id}
    /// DELETE /call-flows/{id}
    Callflow callflow;
    Callflow callflowFromJson;
    final List<String> ids = [];

    setUp(() {
      callflowsService = ApiCallflowsService(credentials['live']);
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

    test('should create a callflow', () async {
      final Callflow createdCallflow = await callflowsService.create(callflow);
      ids.add(createdCallflow.id);
      expect(createdCallflow.title, equals(callflow.title));
      expect(createdCallflow.record, equals(callflow.record));
      expect(createdCallflow.steps[0].id, equals(callflow.steps[0].id));
    });

    test('should delete a callflow', () async {
      await callflowsService.remove(ids[0]);
      await callflowsService.read(ids[0]).catchError((error) {
        expect(error.toString(), contains('(code 13)')); // Not found
      });
    });
  });

  group('ContactsService', () {
    /// Available methods:
    ///
    /// POST /contacts
    /// GET /contacts
    /// GET /contacts/{contactId}
    /// GET /contacts/{contactId}/groups
    /// GET /contacts/{contactId}/messages
    /// PATCH /contacts/{contactId}
    /// DELETE /contacts/{contactId}
    ContactsService contactsService;

    setUp(() {
      contactsService = ApiContactsService(credentials['live']);
    });

    test('gets contacts', () async {
      expect((await contactsService.list()).length, greaterThan(0));
    });
  });

  group('ConversationService', () {
    /// Available methods:
    ///
    /// POST /conversations/start
    /// GET /conversations
    /// GET /conversations/{id}
    /// PATCH /conversations/{id}
    /// GET /conversations/{id}/messages
    /// POST /conversations/{id}/messages

    setUp(() {
      conversationsService = ApiConversationsService(credentials['live']);
    });

    test('should get endpoint', () {
      expect(conversationsService.getEndpoint(), isA<String>());
    });

    test('should start a conversation', () async {
      await conversationsService.start(const ConversationMessage(
          type: MessageType.text,
          content: TextContent('Hello world!'),
          to: '31617692626',
          channelId: 'b6e314222822441a907aa03ef3d425f9'));
    });

    test('should get conversations on our account', () async {
      expect((await conversationsService.list()).length, greaterThan(0));
    });
  });
}
