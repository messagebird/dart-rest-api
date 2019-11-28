import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/general/model/contact.dart';
import 'package:test/test.dart';

void main() {
  group('ContactsService', () {
    Map credentials;
    String id;
    ContactsService contactsService;
    Contact contact;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      contactsService = ApiContactsService(credentials['live']);
      contact = Contact.fromJson(
          File('test_resources/contact.json').readAsStringSync());
    });

    test('should create a contact', () async {
      final Contact createdContact = await contactsService.create(contact);
      id = createdContact.id;
      expect(createdContact.msisdn, contact.msisdn);
      expect(createdContact.firstName, contact.firstName);
      expect(createdContact.lastName, contact.lastName);
    });

    test('should list contacts', () async {
      expect(await contactsService.list(), isNotEmpty);
    });

    test('should get a contact', () async {
      expect((await contactsService.read(id)).msisdn, contact.msisdn);
    });

    test('should get contact groups', () async {
      expect((await contactsService.read(id)).groups, isNotNull);
    });

    test('should get contact messages', () async {
      expect((await contactsService.read(id)).messages, isNotNull);
    });

    test('should update a contact', () async {
      await contactsService.update(Contact(id: id, firstName: 'Lucas'));
      expect((await contactsService.read(id)).firstName, 'Lucas');
    });

    test('should delete a contact', () async {
      await contactsService.remove(id);
      await contactsService.read(id).catchError((error) {
        expect(error.toString(), contains('(code 20)')); // Not found
      });
    });
  });
}
