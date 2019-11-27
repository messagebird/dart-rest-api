import 'dart:io';

import 'package:messagebird_dart/src/calls/model/call.dart';
import 'package:test/test.dart';

void main() {
  group('Call', () {
    Call call;

    setUp(() {
      call = Call.fromJson(File('test_resources/call.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(call.source, equals('3197010240808'));
      expect(call.destination, equals('31617692626'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = call.toMap();

      expect(serialized['source'], equals(call.source));
      expect(serialized['destination'], equals(call.destination));
    });
  });
}
