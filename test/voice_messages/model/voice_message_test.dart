import 'dart:io';

import 'package:messagebird/voice_messaging.dart';
import 'package:test/test.dart';

void main() {
  group('VoiceMessage', () {
    VoiceMessage voiceMessage;

    setUp(() {
      voiceMessage = VoiceMessage.fromJson(
          File('test_resources/voice_message.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(voiceMessage.body, equals('This is a voice message!'));
      expect(voiceMessage.recipients, isA<List>());
      expect(List.from(voiceMessage.recipients)[0], equals(31612345678));
      expect(voiceMessage.originator, equals('+3197010240808'));
      expect(voiceMessage.repeat, equals(2));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = voiceMessage.toMap();

      expect(serialized['body'], equals('This is a voice message!'));
      expect(serialized['recipients'], equals([31612345678]));
      expect(serialized['originator'], equals('+3197010240808'));
      expect(serialized['repeat'], equals(2));
    });
  });
}
