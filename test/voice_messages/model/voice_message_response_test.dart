import 'dart:io';
import 'package:messagebird/voice_messaging.dart';
import 'package:test/test.dart';

void main() {
  group('VoiceMessageResponse', () {
    VoiceMessageResponse voiceMessageResponse;

    setUp(() {
      voiceMessageResponse = VoiceMessageResponse.fromJson(
          File('test_resources/voice_message_response.json')
              .readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(
          voiceMessageResponse.id, equals('e8077d803532c0b5937c639b60216938'));
      expect(voiceMessageResponse.recipients.totalCount,
          equals(voiceMessageResponse.recipients.items.length));
      expect(voiceMessageResponse.recipients.items[0].statusDatetime,
          equals(DateTime.parse('2016-05-03T14:26:57+00:00').toUtc()));
    });
  });
}
