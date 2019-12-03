import 'dart:io';

import 'package:messagebird/conversations.dart';
import 'package:test/test.dart';

void main() {
  group('ConversationMessage', () {
    ConversationMessage message;

    setUp(() {
      message = ConversationMessage.fromJson(
          File('test_resources/conversation_message.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(message.to, equals('+31612345678'));
      expect((message.content as TextContent).text, equals('Hello!'));
      expect(message.fallback.from, equals('2ecea8ee6c564bb4ab15929c44527687'));
      expect(message.fallback.after, equals('5m'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = message.toMap();

      expect(serialized['to'], equals('+31612345678'));
      expect(serialized['content']['text'], equals('Hello!'));
      expect(serialized['fallback']['from'],
          equals('2ecea8ee6c564bb4ab15929c44527687'));
      expect(serialized['fallback']['after'], equals('5m'));
    });
  });
}
