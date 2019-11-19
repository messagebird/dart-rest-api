import 'package:http/http.dart' show Response;

/// Contacts service interface.
abstract class ContactsService {
  /// Create a new contact. [parameters] is optional.
  Future<Response> create(String phoneNumber,
      {Map<String, dynamic> parameters});

  /// Lists existing contacts. Pagination is optional. If a [limit] is set, an
  /// [offset] is also required.
  Future<Response> list({int limit, int offset});

  /// Lists the groups a contact is part of.
  Future<Response> listGroups(String contactId, {int limit, int offset});

  /// Lists the messages for a contact.
  Future<Response> listMessages(String contactId, {int limit, int offset});

  /// View an existing contact.
  Future<Response> read(String id);

  /// Removes an existing contact. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<Response> remove(String id);

  /// Updates an existing contact. [parameters] is optional.
  Future<Response> update(int id, {Map<String, dynamic> parameters});
}
