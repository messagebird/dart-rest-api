import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'groups_service.dart';

/// API implementation of groups service.
class ApiGroupsService extends BaseService implements GroupsService {
  /// Constructor.
  ApiGroupsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> addContacts(String groupId, List<String> contactIds) =>
      get('/groups/$groupId?${_getAddContactsQueryString(contactIds)}');

  @override
  Future<Response> create(String name, {Map<String, dynamic> parameters}) {
    parameters['name'] = name;
    return post('/groups', body: parameters);
  }

  @override
  Future<Response> list({int limit, int offset}) =>
      get('/groups', body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> read(String id) => get('/groups/$id');

  @override
  Future<Response> remove(String id) => delete('/groups/$id');

  @override
  Future<Response> update(String id, String name,
      {Map<String, dynamic> parameters}) {
    parameters['name'] = name;
    return patch('/groups/$id', body: parameters);
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
