import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/balance/api_balance_service.dart';
import 'package:messagebird_dart/src/balance/balance_service.dart';
import 'package:messagebird_dart/src/balance/model/balance.dart';
import 'package:messagebird_dart/src/callflows/model/callflow.dart';
import 'package:messagebird_dart/src/callflows/model/step.dart';
import 'package:messagebird_dart/src/calls/model/call.dart';
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
      callflow = const Callflow(title: 'Say message', record: true, steps: [
        Step(action: StepAction.say, options: {
          StepOption.payload: 'This is a journey into sound. Good bye!',
          StepOption.voice: 'male',
          StepOption.language: 'en-US'
        })
      ]);
    });

    test('should deserialize from json', () {
      expect(callflow.title, equals(callflowFromJson.title));
      expect(callflow.record, equals(callflowFromJson.record));
      expect(
          callflow.steps[0].action, equals(callflowFromJson.steps[0].action));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = callflowFromJson.toMap();

      expect(serialized['id'], equals(callflowFromJson.id));
      expect(serialized['title'], equals(callflowFromJson.title));
      expect(serialized['record'], equals(callflowFromJson.record));
      expect(
          serialized['steps'][0]['id'], equals(callflowFromJson.steps[0].id));
    });

    test('should list callflows', () async {
      expect(await callflowsService.list(), isNotEmpty);
    });

    test('should create a callflow', () async {
      final Callflow createdCallflow = await callflowsService.create(callflow);
      ids.add(createdCallflow.id);
      expect(createdCallflow.title, equals(callflow.title));
      expect(createdCallflow.record, equals(callflow.record));
      expect(createdCallflow.steps[0].action, equals(callflow.steps[0].action));
    });

    test('should get a callflow', () async {
      expect(await callflowsService.read(ids[0]), isNotNull);
    });

    test('should update a callflow', () async {
      await callflowsService.update(Callflow(id: ids[0], title: 'Test', steps: [
        const Step(
            action: StepAction.transfer,
            options: {StepOption.destination: '31611223344'})
      ]));
      expect((await callflowsService.read(ids[0])).title, 'Test');
    });

    test('should delete a callflow', () async {
      await callflowsService.remove(ids[0]);
      await callflowsService.read(ids[0]).catchError((error) {
        expect(error.toString(), contains('(code 13)')); // Not found
      });
    });
  });

  group('CallsService', () {
    /// Available methods:
    ///
    /// POST /calls/
    /// GET /calls/
    /// GET /calls/{callID}
    /// DELETE /calls/{callID}
    /// GET /calls/{callID}/legs
    /// GET /calls/{callID}/legs/{legID}
    final List<String> ids = [];
    CallsService callsService;
    Call call;
    Callflow callflow;

    setUp(() {
      callsService = ApiCallsService(credentials['live']);
      call = Call.fromJson(File('test_resources/call.json').readAsStringSync());
      callflow = Callflow.fromJson(
          File('test_resources/callflow.json').readAsStringSync());
    });

    test('should create a call', () async {
      final Call createdCall = await callsService.create(call, callflow);
      ids.add(createdCall.id);
      expect(createdCall.source, equals(call.source));
    });

    test('should list calls', () async {
      expect(await callsService.list(), isNotEmpty);
    });

    test('should get a call', () async {
      expect((await callsService.read(ids[0])).id, isNotNull);
    });

    test('should update a call', () async {
      // Not testable.
    });

    test('should delete a call', () async {
      await callsService.remove(ids[0]);
      await callsService.read(ids[0]).catchError((error) {
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
      expect(await contactsService.list(), isNotEmpty);
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
      expect(await conversationsService.list(), isNotEmpty);
    });
  });
}
