import '../general/model/contact.dart';
import '../general/model/groups.dart';
import '../general/model/messages.dart';

/// Contacts service interface.
abstract class ContactsService {
  /// Create a new [Contact]. Parameters are optional.
  Future<Contact> create(Contact contact);

  /// Lists existing [Contact] objects. Pagination is optional. If a [limit] is
  /// set, an [offset] is also required.
  Future<List<Contact>> list({int limit, int offset});

  /// Lists the [Groups] a contact is part of.
  Future<Groups> listGroups(String contactId, {int limit, int offset});

  /// Lists the [Messages] for a contact.
  Future<Messages> listMessages(String contactId, {int limit, int offset});

  /// View an existing [Contact].
  Future<Contact> read(String id);

  /// Removes an existing [Contact]. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<void> remove(String id);

  /// Updates an existing [Contact]. parameters are optional.
  Future<Contact> update(Contact contact);
}
