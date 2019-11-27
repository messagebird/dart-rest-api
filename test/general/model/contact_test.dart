import 'dart:io';

import 'package:messagebird_dart/src/general/model/contact.dart';
import 'package:test/test.dart';

void main() {
  group('Contact', () {
    Contact contact;

    setUp(() {
      contact =
          Contact.fromJson(File('test_resources/call.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(contact.msisdn, equals('31617692626'));
      expect(contact.firstName, equals('Luc'));
      expect(contact.lastName, equals('van der Zandt'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = contact.toMap();

      expect(serialized['msisdn'], equals('31617692626'));
      expect(serialized['firstName'], equals('Luc'));
      expect(serialized['lastName'], equals('van der Zandt'));
    });
  });
}
