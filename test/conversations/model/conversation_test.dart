import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('Conversation', () {
    Conversation conversation;

    setUp(() {
      conversation = Conversation.fromJson(
          File('test_resources/conversation.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(conversation.id, equals('2e15efafec384e1c82e9842075e87beb'));
      expect(
          conversation.contact.id, equals('a621095fa44947a28b441cfdf85cb802'));
      expect(conversation.channels[0].name, equals('SMS'));
      expect(conversation.createdDatetime,
          equals(DateTime.parse('2018-08-13T09:17:22Z')));
      expect(
          conversation.messages.href,
          equals(
              'https://conversations.messagebird.com/v1/conversations/2e15efafec384e1c82e9842075e87beb/messages'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = conversation.toMap();

      expect(serialized['id'], equals('2e15efafec384e1c82e9842075e87beb'));
      expect(serialized['contact']['id'],
          equals('a621095fa44947a28b441cfdf85cb802'));
      expect(serialized['channels'][0]['name'], equals('SMS'));
      expect(serialized['createdDatetime'],
          equals(DateTime.parse('2018-08-13T09:17:22Z').toString()));
      expect(
          serialized['messages']['href'],
          equals(
              'https://conversations.messagebird.com/v1/conversations/2e15efafec384e1c82e9842075e87beb/messages'));
    });
  });
}
