import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'groups_service.dart';
import 'model/group.dart';

/// API implementation of groups service.
class ApiGroupsService extends BaseService implements GroupsService {
  /// Constructor.
  ApiGroupsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<void> addContacts(String groupId, List<String> contactIds) =>
      put('/groups/$groupId?${_getAddContactsQueryString(contactIds)}');

  @override
  Future<void> removeContacts(String groupId, List<String> contactIds) =>
      remove('/groups/$groupId?${_getAddContactsQueryString(contactIds)}');

  @override
  Future<Group> create(Group group) => post('/groups', body: group.toMap())
      .then((response) => Future.value(Group.fromJson(response.body)));

  @override
  Future<List<Group>> list({int limit, int offset}) =>
      get('/groups', body: {'limit': limit, 'offset': offset})
          .then((response) => Future.value(Group.fromJsonList(response.body)));

  @override
  Future<Group> read(String id) => get('/groups/$id')
      .then((response) => Future.value(Group.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete('/groups/$id');

  @override
  Future<Group> update(String id, {Group group}) =>
      patch('/groups/$id', body: group.toMap())
          .then((response) => Future.value(Group.fromJson(response.body)));

  String _getAddContactsQueryString(List<String> contactIds) {
    // Map the contact IDs to the
    // `_method=PUT&ids[]=contact-id&ids[]=other-contact-id` format. See
    // docs in addContacts and:
    // * https://developers.messagebird.com/docs/alternatives
    // * https://developers.messagebird.com/docs/groups#add-contact-to-group
    final List<String> parameters = [];
    parameters.add('_method=PUT');
    for (var i = 0; i < contactIds.length; i++) {
      parameters.add('ids[]=${contactIds[i]}');
    }
    return parameters.join('&');
  }
}
