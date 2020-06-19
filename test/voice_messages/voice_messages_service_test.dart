import 'dart:io';

import 'package:messagebird/voice_messaging.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  group('VoiceMessagesService', () {
    Credentials credentials;
    String id;
    VoiceMessagesService voiceMessagesService;

    setUp(() {
      credentials = Credentials.from(Platform.environment);
      voiceMessagesService = ApiVoiceMessagesService(credentials.API_LIVE_KEY);
    });

    test('should send a voice message', () {
      voiceMessagesService
          .create(VoiceMessage(
              body: 'Hello world from a voice message!',
              recipients: [credentials.MSISDN]))
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
