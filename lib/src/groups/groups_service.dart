import 'package:http/http.dart' show Response;

/// Groups service interface.
abstract class GroupsService {
  /// Adds anywhere from 1 to 50 contacts to a group.
  Future<Response> addContacts(String groupId, List<String> contactIds);

  /// Creates a new Group. [parameters] is optional.
  Future<Response> create(String name, {Map<String, dynamic> parameters});

  /// Lists existing groups. Pagination is optional. If a [limit] is set, an
  /// [offset] is also required.
  Future<Response> list({int limit, int offset});

  /// View an existing group
  Future<Response> read(String id);

  /// Removes an existing group. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<Response> remove(String id);

  /// Updates an existing contact. [parameters] is optional.
  Future<Response> update(String id, String name,
      {Map<String, dynamic> parameters});
}
