import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('VoiceMessagesService', () {
    Map credentials;
    String id;
    VoiceMessagesService voiceMessagesService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      voiceMessagesService = ApiVoiceMessagesService(credentials['live']);
    });

    test('should send a voice message', () {
      voiceMessagesService
          .create(VoiceMessage(
              body: 'Hello world from a voice message!',
              recipients: [credentials['msisdn']]))
          .then((response) {
        expect(response.id, isNotNull);
        expect(response.body, equals('Hello world from a voice message!'));
        expect(response.voice, equals(Voice.female)); // Default
        id = response.id;
      });
    });

    test('should read a voice message', () {
      voiceMessagesService.read(id).then((response) {
        expect(response.id, equals(id));
        expect(response.body, equals('Hello world from a voice message!'));
        expect(response.voice, equals(Voice.female)); // Default
      });
    });
  });
}
