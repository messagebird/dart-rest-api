import '../base_service.dart';
import 'contacts_service.dart';
import 'model/contact.dart';
import 'model/groups.dart';
import 'model/messages.dart';

/// API implementation of [ContactsService].
class ApiContactsService extends BaseService implements ContactsService {
  /// Constructor.
  ApiContactsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Contact> create(Contact contact) async {
    final response = await post('/contacts', body: contact.toMap());
    return Future.value(Contact.fromJson(response.body));
  }

  @override
  Future<List<Contact>> list({int limit, int offset}) async {
    final response =
        await get('/contacts', body: {'limit': limit, 'offset': offset});
    return Future.value(Contact.fromJsonList(response.body));
  }

  @override
  Future<Groups> listGroups(String contactId, {int limit, int offset}) async {
    final response = await get('/contacts/$contactId/groups',
        body: {'limit': limit, 'offset': offset});
    return Future.value(Groups.fromJson(response.body));
  }

  @override
  Future<Messages> listMessages(String contactId,
      {int limit, int offset}) async {
    final response = await get('/contacts/$contactId/messages',
        body: {'limit': limit, 'offset': offset});
    return Future.value(Messages.fromJson(response.body));
  }

  @override
  Future<Contact> read(String id) async {
    final response = await get('/contacts/$id');
    return Future.value(Contact.fromJson(response.body));
  }

  @override
  Future<void> remove(String id) => delete('/contacts/$id');

  @override
  Future<Contact> update(Contact contact) async {
    final response =
        await patch('/contacts/${contact.id}', body: contact.toMap());
    return Future.value(Contact.fromJson(response.body));
  }
}
