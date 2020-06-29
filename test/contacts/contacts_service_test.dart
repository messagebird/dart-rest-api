import 'dart:io';

import 'package:messagebird/contacts.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('ContactsService', () {
    String id;
    ContactsService contactsService;
    Contact contact;

    setUp(() {
      contactsService = ApiContactsService(credentials.API_LIVE_KEY);

      final contactSource =
          File('test_resources/contact.json').readAsStringSync();
      if (credentials.hasMSISDN) {
        contactSource.replaceAll('31612345678', credentials.MSISDN.toString());
      }

      contact = Contact.fromJson(contactSource);
    });

    test('should create a contact', () {
      contactsService.create(contact).then((createdContact) {
        id = createdContact.id;
        expect(createdContact.msisdn, contact.msisdn);
        expect(createdContact.firstName, contact.firstName);
        expect(createdContact.lastName, contact.lastName);
      });
    });

    test('should list contacts', () {
      contactsService.list().then((list) {
        expect(list, isNotEmpty);
      });
    });

    test('should get a contact', () {
      contactsService.read(id).then((readContact) {
        expect(readContact.msisdn, contact.msisdn);
      });
    });

    test('should get contact groups', () {
      contactsService.read(id).then((readContact) {
        expect(readContact.groups, isA<Groups>());
      });
    });

    test('should get contact messages', () {
      contactsService.read(id).then((readContact) {
        expect(readContact.messages, isA<Messages>());
      });
    });

    test('should update a contact', () {
      contactsService
          .update(Contact(id: id, firstName: 'Lucas'))
          .then((updatedContact) {
        contactsService.read(id).then((readContact) {
          expect(readContact.firstName, equals(updatedContact.firstName));
        });
      });
    });

    test('should delete a contact', () {
      contactsService.remove(id);
      contactsService.read(id).then((readContact) {
        expect(readContact, isNull);
      });
    });
  }, skip: !credentials.arePresent);
}
