import 'dart:io';

import 'package:messagebird/conversations.dart';
import 'package:test/test.dart';

void main() {
  group('Message', () {
    Message message;

    setUp(() {
      message = Message.fromJson(
          File('test_resources/message.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(message.id, equals('13a97a5023944648b8e5e61248c40da8'));
      expect(message.platform, isNull);
      expect(message.to, equals('+31612345678'));
      expect(message.direction, equals(MessageDirection.sent));
      expect(message.content, isA<TextContent>());
      expect((message.content as TextContent).text,
          equals('This is a test message'));
      expect(message.source['foo'], equals('bar'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = message.toMap();

      expect(serialized['id'], equals('13a97a5023944648b8e5e61248c40da8'));
      expect(serialized['platform'], isNull);
      expect(serialized['to'], equals('+31612345678'));
      expect(serialized['direction'], equals('sent'));
      expect(serialized['content']['text'], equals('This is a test message'));
      expect(serialized['source']['foo'], equals('bar'));
    });
  });
}
