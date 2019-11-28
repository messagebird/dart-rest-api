import 'dart:io';

import 'package:messagebird_dart/src/groups/model/group.dart';
import 'package:test/test.dart';

void main() {
  group('Group', () {
    Group group;

    setUp(() {
      group =
          Group.fromJson(File('test_resources/group.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(group.id, equals('61afc0531573b08ddbe36e1c85602827'));
      expect(group.contacts.totalCount, equals(0));
      expect(
          group.createdDatetime, DateTime.parse('2016-04-29T09:42:26+00:00'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = group.toMap();

      expect(serialized['id'], equals('61afc0531573b08ddbe36e1c85602827'));
      expect(serialized['contacts']['totalCount'], equals(0));
      expect(serialized['createdDatetime'],
          equals(DateTime.parse('2016-04-29T09:42:26+00:00').toString()));
    });
  });
}
