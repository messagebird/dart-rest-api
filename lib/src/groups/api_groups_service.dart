import 'dart:convert';

import '../base_service.dart';
import 'groups_service.dart';
import 'model/group.dart';

/// API implementation of groups service.
class ApiGroupsService extends BaseService implements GroupsService {
  /// Constructor.
  ApiGroupsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<void> addContacts(String groupId, List<String> contactIds) async {
    await put('/groups/$groupId?${_getAddContactsQueryString(contactIds)}');
    return Future.value();
  }

  @override
  Future<void> removeContacts(String groupId, List<String> contactIds) async {
    await remove('/groups/$groupId?${_getAddContactsQueryString(contactIds)}');
    return Future.value();
  }

  @override
  Future<Group> create(Group group) async {
    final response = await post('/groups', body: group.toJson());
    return Future.value(Group.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<List<Group>> list({int limit, int offset}) async {
    final response =
        await get('/groups', body: {'limit': limit, 'offset': offset});
    return Future.value(Group.fromJsonList(json.decode(response.body)['data']));
  }

  @override
  Future<Group> read(String id) async {
    final response = await get('/groups/$id');
    return Future.value(Group.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<void> remove(String id) => delete('/groups/$id');

  @override
  Future<Group> update(String id, {Group group}) async {
    final response = await patch('/groups/$id', body: group.toJson());
    return Future.value(Group.fromJson(json.decode(response.body)['data']));
  }

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
