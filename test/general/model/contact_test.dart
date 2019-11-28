import 'dart:io';

import 'package:messagebird_dart/src/general/model/contact.dart';
import 'package:test/test.dart';

void main() {
  group('Contact', () {
    Contact contact;

    setUp(() {
      contact = Contact.fromJson(
          File('test_resources/contact.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(contact.msisdn, equals('31617692626'));
      expect(contact.firstName, equals('Luc'));
      expect(contact.lastName, equals('van der Zandt'));
      expect(
          contact.groups.href,
          equals(
              'https://rest.messagebird.com/contacts/61afc0531573b08ddbe36e1c85602827/groups'));
      expect(
          contact.messages.href,
          equals(
              'https://rest.messagebird.com/contacts/61afc0531573b08ddbe36e1c85602827/messages'));
      expect(contact.createdDatetime,
          equals(DateTime.parse('2016-04-29T09:42:26+00:00')));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = contact.toMap();

      expect(serialized['msisdn'], equals('31617692626'));
      expect(serialized['firstName'], equals('Luc'));
      expect(serialized['lastName'], equals('van der Zandt'));
      expect(
          serialized['groups']['href'],
          equals(
              'https://rest.messagebird.com/contacts/61afc0531573b08ddbe36e1c85602827/groups'));
      expect(
          serialized['messages']['href'],
          equals(
              'https://rest.messagebird.com/contacts/61afc0531573b08ddbe36e1c85602827/messages'));
      expect(serialized['createdDatetime'],
          equals(DateTime.parse('2016-04-29T09:42:26+00:00').toString()));
    });
  });
}
