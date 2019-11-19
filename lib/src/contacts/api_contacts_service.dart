import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'contacts_service.dart';

/// API implementation of contacts service.
class ApiContactsService extends BaseService implements ContactsService {
  /// Constructor.
  ApiContactsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(String phoneNumber,
      {Map<String, dynamic> parameters}) {
    parameters['msisdn'] = phoneNumber;
    return post('/contacts', body: parameters);
  }

  @override
  Future<Response> list({int limit, int offset}) =>
      get('/contacts', body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> listGroups(String contactId, {int limit, int offset}) =>
      get('/contacts/$contactId/groups',
          body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> listMessages(String contactId, {int limit, int offset}) =>
      get('/contacts/$contactId/messages',
          body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> read(String id) => get('/contacts/$id');

  @override
  Future<Response> remove(String id) => delete('/contacts/$id');

  @override
  Future<Response> update(int id, {Map<String, dynamic> parameters}) =>
      patch('/contacts/$id', body: parameters);
}
