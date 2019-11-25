import 'package:messagebird_dart/src/general/model/contact.dart';
import 'package:messagebird_dart/src/general/model/groups.dart';
import 'package:messagebird_dart/src/general/model/messages.dart';

import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'contacts_service.dart';

/// API implementation of [ContactsService].
class ApiContactsService extends BaseService implements ContactsService {
  /// Constructor.
  ApiContactsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Contact> create(Contact contact) =>
      post('/contacts', body: contact.toMap())
          .then((response) => Future.value(Contact.fromJson(response.body)));

  @override
  Future<List<Contact>> list({int limit, int offset}) =>
      get('/contacts', body: {'limit': limit, 'offset': offset}).then(
          (response) => Future.value(Contact.fromJsonList(response.body)));

  @override
  Future<Groups> listGroups(String contactId, {int limit, int offset}) =>
      get('/contacts/$contactId/groups',
              body: {'limit': limit, 'offset': offset})
          .then((response) => Future.value(Groups.fromJson(response.body)));

  @override
  Future<Messages> listMessages(String contactId, {int limit, int offset}) =>
      get('/contacts/$contactId/messages',
              body: {'limit': limit, 'offset': offset})
          .then((response) => Future.value(Messages.fromJson(response.body)));

  @override
  Future<Contact> read(String id) => get('/contacts/$id')
      .then((response) => Future.value(Contact.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete('/contacts/$id');

  @override
  Future<Contact> update(Contact contact) =>
      patch('/contacts/${contact.id}', body: contact.toMap())
          .then((response) => Future.value(Contact.fromJson(response.body)));
}
