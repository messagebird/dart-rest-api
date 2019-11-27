import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/conversations/model/conversation_message.dart';
import 'package:messagebird_dart/src/general/model/content.dart';
import 'package:messagebird_dart/src/general/model/message.dart';
import 'package:test/test.dart';

void main() {
  group('ConversationService', () {
    Map credentials;
    ConversationsService conversationsService;
    const String conversationId = '8194ecfd1c3f4260b4e1680cb04f551f';

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      conversationsService = ApiConversationsService(credentials['live']);
    });

    test('should get endpoint', () {
      expect(conversationsService.getEndpoint(), isA<String>());
    });

    test('should start a conversation', () {
      // Not available for WhatsApp or Telegram, skipping
    });

    test('should get conversations on our account', () async {
      expect(await conversationsService.list(), isNotEmpty);
    });

    test('should get a conversation on our account', () async {
      expect(await conversationsService.list(), isNotEmpty);
    });

    test('should reply to a conversation', () async {
      expect(
          (await conversationsService.reply(
                  conversationId,
                  const ConversationMessage(
                      type: MessageType.text,
                      content: TextContent('Hello world!'),
                      channelId: 'b6e314222822441a907aa03ef3d425f9')))
              .status,
          isIn([
            MessageStatus.pending,
            MessageStatus.delivered,
            MessageStatus.received,
            MessageStatus.read
          ]));
    });

    test('should get the messages in a conversation', () async {
      expect(
          await conversationsService.listMessages(conversationId), isNotEmpty);
    });

    test('should archive a conversation', () async {
      //expect(await conversationsService.list(), isNotEmpty);
    });
  });
}
