import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('Contact', () {
    Contact contact;
    int msisdn;

    setUp(() {
      msisdn = json.decode(
          File('test_resources/keys.json').readAsStringSync())['msisdn'];
      contact = Contact.fromJson(File('test_resources/contact.json')
          .readAsStringSync()
          .replaceAll('31612345678', msisdn.toString()));
    });

    test('should deserialize from json', () {
      expect(contact.msisdn, equals(msisdn.toString()));
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

      expect(serialized['msisdn'], equals(msisdn.toString()));
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
