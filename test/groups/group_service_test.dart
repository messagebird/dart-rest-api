import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/general/model/contact.dart';
import 'package:messagebird_dart/src/groups/model/group.dart';
import 'package:test/test.dart';

void main() {
  group('GroupService', () {
    Map credentials;
    String id;
    GroupsService groupsService;
    // John Doe contact
    const String contactId = 'ed105b2ba26446f9ab0ce213457e99bc';

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      groupsService = ApiGroupsService(credentials['test']);
    });

    test('should create a group', () async {
      final Group group =
          await groupsService.create(const Group(name: 'Testgroup'));
      expect(group.name, equals('Testgroup'));
      expect(group.id, isNotNull);
      id = group.id;
    });

    test('should view a group', () async {
      final Group group = await groupsService.read(id);
      expect(group.name, equals('Testgroup'));
      expect(group.id, id);
    });

    test('should add a contact to a group', () async {
      await groupsService.addContacts(id, [contactId]);
      final Group group = await groupsService.read(id);
      expect(group.contacts.totalCount, equals(1));
    });

    test('should get members of a group', () async {
      final List<Contact> contacts = await groupsService.listContacts(id);
      expect(contacts, isNotEmpty);
      expect(contacts.length, equals(1));
      expect(contacts[0].id, equals(contactId));
    });

    test('should remove a contact from a group', () async {
      await groupsService.removeContact(id, contactId);
      final Group group = await groupsService.read(id);
      expect(group.contacts.totalCount, equals(0));
    });

    test('should update a group', () async {
      await groupsService.update(id, group: const Group(name: 'Hello world!'));
      final Group group = await groupsService.read(id);
      expect(group.name, equals('Hello world!'));
    });

    test('should remove a group', () async {
      await groupsService.remove(id);
      await groupsService.read(id).catchError((error) {
        expect(error.toString(), contains('(code 20)')); // Not found
      });
    });
  });
}
