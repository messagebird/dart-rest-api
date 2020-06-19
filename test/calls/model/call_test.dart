import 'dart:io';

import 'package:messagebird/voice_calling.dart';
import 'package:test/test.dart';

void main() {
  group('Call', () {
    Call call;
    int msisdn;

    setUp(() {
      call = Call.fromJson(File('test_resources/call.json')
          .readAsStringSync()
          .replaceAll('31612345678', msisdn.toString()));
    });

    test('should deserialize from json', () {
      expect(call.source, equals('3197010240808'));
      expect(call.destination, equals(msisdn.toString()));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = call.toMap();

      expect(serialized['source'], equals(call.source));
      expect(serialized['destination'], equals(call.destination));
    });
  });
}
