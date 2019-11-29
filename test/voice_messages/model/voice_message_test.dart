import 'dart:io';
import 'package:messagebird_dart/src/voice_messages/model/voice_message.dart';
import 'package:test/test.dart';

void main() {
  group('VoiceMessage', () {
    VoiceMessage voiceMessage;

    setUp(() {
      voiceMessage = VoiceMessage.fromJson(
          File('test_resources/recording.json').readAsStringSync());
    });

    test('should deserialize from json', () {});

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = voiceMessage.toMap();
    });
  });
}
