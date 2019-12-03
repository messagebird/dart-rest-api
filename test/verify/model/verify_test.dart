import 'dart:convert';
import 'dart:io';
import 'package:messagebird/verify.dart';
import 'package:messagebird/voice_messaging.dart';
import 'package:test/test.dart';

void main() {
  group('Verify', () {
    Verify verify;
    int msisdn;

    setUp(() {
      msisdn = json.decode(
          File('test_resources/keys.json').readAsStringSync())['msisdn'];
      verify = Verify.fromJson(File('test_resources/verify.json')
          .readAsStringSync()
          .replaceAll('31612345678', msisdn.toString()));
    });

    test('should deserialize from json', () {
      expect(verify.recipient, equals(msisdn));
      expect(verify.originator, equals('Drillster'));
      expect(verify.template, equals('Je code is: %token'));
      expect(verify.voice, equals(Voice.female));
      expect(verify.language, equals('nl-nl'));
      expect(verify.reference, isNull);
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = verify.toMap();

      expect(serialized['recipient'], equals(msisdn));
      expect(serialized['originator'], equals('Drillster'));
      expect(serialized['template'], equals('Je code is: %token'));
      expect(serialized['voice'], equals('female'));
      expect(serialized['language'], equals('nl-nl'));
      expect(serialized['reference'], isNull);
    });
  });
}
