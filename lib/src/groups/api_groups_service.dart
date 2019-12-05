import '../general/model/base_service.dart';
import '../general/model/contact.dart';
import 'groups_service.dart';
import 'model/group.dart';

/// API implementation of groups service.
class ApiGroupsService extends BaseService implements GroupsService {
  /// Constructor.
  ApiGroupsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<List<Contact>> listContacts(String groupId) =>
      get('/groups/$groupId/contacts').then((response) => Future.value(
          response?.body == null ? null : Contact.fromJsonList(response.body)));

  @override
  Future<void> addContacts(String groupId, List<String> contactIds) =>
      put('/groups/$groupId/contacts', body: {'ids': contactIds});

  @override
  Future<void> removeContact(String groupId, String contactId) =>
      delete('/groups/$groupId/contacts/$contactId');

  @override
  Future<Group> create(Group group) =>
      post('/groups', body: group.toMap()).then((response) => Future.value(
          response?.body == null ? null : Group.fromJson(response.body)));

  @override
  Future<List<Group>> list({int limit, int offset}) => get('/groups',
          body: {'limit': limit, 'offset': offset})
      .then((response) => Future.value(
          response?.body == null ? null : Group.fromJsonList(response.body)));

  @override
  Future<Group> read(String id) =>
      get('/groups/$id').then((response) => Future.value(
          response?.body == null ? null : Group.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete('/groups/$id');

  @override
  Future<Group> update(String id, {Group group}) =>
      patch('/groups/$id', body: group.toMap()).then((response) => Future.value(
          response?.body == null ? null : Group.fromJson(response.body)));
}
