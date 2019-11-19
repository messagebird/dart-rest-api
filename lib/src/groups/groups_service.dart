import 'package:http/http.dart' show Response;

/// Groups service interface
abstract class GroupsService {
  /// Creates a new Group. [parameters] is optional
  Future<Response> createGroup(String name, {Map<String, dynamic> parameters});

  /// Deletes an existing group. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<Response> deleteGroup(String id);

  /// Lists existing groups. Pagination is optional. If a [limit] is set, an
  /// [offset] is also required.
  Future<Response> listGroups({int limit, int offset});

  /// View an existing group
  Future<Response> readGroup(String id);

  /// Updates an existing contact. [parameters] is optional.
  Future<Response> updateGroup(String id, String name,
      {Map<String, dynamic> parameters});

  /// Adds anywhere from 1 to 50 contacts to a group
  Future<Response> addContacts(String groupId, List<String> contactIds);
}
