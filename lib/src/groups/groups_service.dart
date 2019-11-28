import 'package:messagebird_dart/src/general/model/contact.dart';

import 'model/group.dart';

/// Groups service interface.
abstract class GroupsService {
  /// Add contact to group. The ID of the group needs to be supplied.
  Future<List<Contact>> listContacts(String groupId);

  /// Add contact to group. The IDs of the group and contact need to be
  /// supplied.
  Future<void> addContacts(String groupId, List<String> contactIds);

  /// Remove contact to group. The IDs of the group and contact need to be
  /// supplied.
  Future<void> removeContact(String groupId, String contactId);

  /// Create a new Group. Parameters are optional.
  Future<Group> create(Group group);

  /// List existing groups. Pagination is optional. If a [limit] is set, an
  /// [offset] is also required.
  Future<List<Group>> list({int limit, int offset});

  /// View an existing group
  Future<Group> read(String id);

  /// Remove an existing group. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<void> remove(String id);

  /// Update an existing contact. Parameters are optional.
  Future<Group> update(String id, {Group group});
}
