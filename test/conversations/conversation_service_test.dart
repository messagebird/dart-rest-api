import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
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

    test('should get conversations on our account', () {
      conversationsService.list().then((list) {
        expect(list, isNotEmpty);
      });
    });

    test('should reply to a conversation', () {
      conversationsService
          .reply(
              conversationId,
              const ConversationMessage(
                  type: MessageType.text,
                  content: TextContent('Hello world!'),
                  channelId: 'b6e314222822441a907aa03ef3d425f9'))
          .then((message) {
        expect(
            message.status,
            isIn([
              MessageStatus.pending,
              MessageStatus.delivered,
              MessageStatus.received,
              MessageStatus.read
            ]));
      });
    });

    test('should list messages in a conversation', () {
      conversationsService.listMessages(conversationId).then((list) {
        expect(list, isNotEmpty);
      });
    });

    test('should archive a conversation', () async {
      // Not implemented.
    });
  });
}
