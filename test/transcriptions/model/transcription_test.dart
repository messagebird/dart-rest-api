import 'dart:io';
import 'package:messagebird_dart/src/transcriptions/model/transcription.dart';
import 'package:test/test.dart';

void main() {
  group('Transcription', () {
    Transcription transcription;

    setUp(() {
      transcription = Transcription.fromJson(
          File('test_resources/transcription.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(transcription.id, equals('87c377ce-1629-48b6-ad01-4b4fd069c53c'));
      expect(transcription.error, isNull);
      expect(
          transcription.links['file'],
          Uri.parse(
              '/calls/096d3500-0f6e-4c0f-89a1-41934458ee69/legs/124906d6-b745-435e-aabc-8005dbc5ccf3/recordings/07fda3f9-ddd3-4267-ab01-71cf55df31df/transcriptions/87c377ce-1629-48b6-ad01-4b4fd069c53c.txt'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = transcription.toMap();

      expect(serialized['id'], equals('87c377ce-1629-48b6-ad01-4b4fd069c53c'));
      expect(serialized['error'], isNull);
      expect(serialized['_links']['file'],
          '/calls/096d3500-0f6e-4c0f-89a1-41934458ee69/legs/124906d6-b745-435e-aabc-8005dbc5ccf3/recordings/07fda3f9-ddd3-4267-ab01-71cf55df31df/transcriptions/87c377ce-1629-48b6-ad01-4b4fd069c53c.txt');
    });
  });
}
