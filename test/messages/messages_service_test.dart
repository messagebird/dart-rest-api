import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/general/model/message.dart';
import 'package:test/test.dart';

void main() {
  group('MessagesService', () {
    Map credentials;
    MessagesService messagesService;
    const String messageId = '65426858e6d546fa8eb5ae992ed874f2';

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      messagesService = ApiMessagesService(credentials['live']);
    });

    test('should read a message', () async {
      final Message message = await messagesService.read(messageId);
      expect(message, isNotNull);
      expect(message.type, equals(MessageType.text));
      expect(message.platform, equals('telegram'));
    });
  });
}
