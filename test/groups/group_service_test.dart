import 'dart:io';

import 'package:messagebird/groups.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('GroupService', () {
    String id;
    GroupsService groupsService;
    // John Doe contact
    const String contactId = 'ed105b2ba26446f9ab0ce213457e99bc';

    setUp(() {
      groupsService = ApiGroupsService(credentials.API_TEST_KEY);
    });

    test('should create a group', () {
      groupsService.create(const Group(name: 'Testgroup')).then((group) {
        expect(group.name, equals('Testgroup'));
        expect(group.id, isNotNull);
        id = group.id;
      });
    });

    test('should view a group', () {
      groupsService.read(id).then((group) {
        expect(group.name, equals('Testgroup'));
        expect(group.id, id);
      });
    });

    test('should add a contact to a group', () {
      groupsService.addContacts(id, [contactId]);
      groupsService.read(id).then((group) {
        expect(group.contacts.totalCount, equals(1));
      });
    });

    test('should get members of a group', () {
      groupsService.listContacts(id).then((contacts) {
        expect(contacts, isNotEmpty);
        expect(contacts.length, equals(1));
        expect(contacts[0].id, equals(contactId));
      });
    });

    test('should remove a contact from a group', () {
      groupsService.removeContact(id, contactId);
      groupsService.read(id).then((group) {
        expect(group.contacts.totalCount, isZero);
      });
    });

    test('should update a group', () {
      groupsService.update(id, group: const Group(name: 'Hello world!'));
      groupsService.read(id).then((group) {
        expect(group.name, equals('Hello world!'));
      });
    });

    test('should remove a group', () {
      groupsService.remove(id);
      groupsService.read(id).then((group) {
        expect(group, isNull);
      });
    });
  }, skip: !credentials.arePresent);
}
