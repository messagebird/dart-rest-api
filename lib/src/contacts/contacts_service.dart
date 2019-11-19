import 'package:http/http.dart' show Response;

/// Contacts service interface
abstract class ContactsService {
  /// Create a new contact. [parameters] is optional.
  Future<Response> createContact(String phoneNumber,
      {Map<String, dynamic> parameters});

  /// Deletes an existing contact. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<Response> deleteContact(String id);

  /// Lists existing contacts. Pagination is optional. If a [limit] is set, an
  /// [offset] is also required.
  Future<Response> listContacts({int limit, int offset});

  /// View an existing contact.
  Future<Response> readContact(String id);

  /// Updates an existing contact. [parameters] is optional.
  Future<Response> updateContact(int id, {Map<String, dynamic> parameters});

  /// Lists the groups a contact is part of.
  Future<Response> listGroupsOfContact(String contactId,
      {int limit, int offset});

  /// Lists the messages for a contact.
  Future<Response> listMesssagesForContact(String contactId,
      {int limit, int offset});
}
