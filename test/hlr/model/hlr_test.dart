import 'dart:io';

import 'package:messagebird_dart/src/hlr/model/hlr.dart';
import 'package:test/test.dart';

void main() {
  group('Hlr', () {
    Hlr hlr;

    setUp(() {
      hlr = Hlr.fromJson(File('test_resources/hlr.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(hlr.id, equals('0da180b035398662ceb3c42h04904985'));
      expect(hlr.details.country_iso, equals('NLD'));
      expect(hlr.status, HlrStatus.active);
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = hlr.toMap();

      expect(serialized['id'], equals('0da180b035398662ceb3c42h04904985'));
      expect(serialized['details']['country_iso'], equals('NLD'));
      expect(serialized['status'], equals('active'));
    });
  });
}
