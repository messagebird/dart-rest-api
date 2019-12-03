import 'dart:io';
import 'package:messagebird/voice_calling.dart';
import 'package:test/test.dart';

void main() {
  group('Recording', () {
    Recording recording;

    setUp(() {
      recording = Recording.fromJson(
          File('test_resources/recording.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(recording.id, equals('3b4ac358-9467-4f7a-a6c8-6157ad181123'));
      expect(recording.duration, equals(7));
      expect(recording.createdAt,
          equals(DateTime.parse('2017-05-17 11:42:57.000Z')));
      expect(
          recording.links['file'],
          equals(Uri.parse(
              '/calls/bb3f0391-4fdc-4e38-9551-e8a01602984f/legs/cc3bd14d-3eee-4380-b01f-fe7723c69a31/recordings/3b4ac358-9467-4f7a-a6c8-6157ad181123.wav')));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = recording.toMap();

      expect(serialized['id'], equals('3b4ac358-9467-4f7a-a6c8-6157ad181123'));
      expect(serialized['duration'], equals(7));
      expect(serialized['createdAt'], equals('2017-05-17 11:42:57.000Z'));
      expect(
          serialized['_links']['file'],
          equals(
              '/calls/bb3f0391-4fdc-4e38-9551-e8a01602984f/legs/cc3bd14d-3eee-4380-b01f-fe7723c69a31/recordings/3b4ac358-9467-4f7a-a6c8-6157ad181123.wav'));
    });
  });
}
