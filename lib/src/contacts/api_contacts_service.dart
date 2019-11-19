import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'contacts_service.dart';

/// API implementation of contacts service
class ApiContactsService extends BaseService implements ContactsService {
  /// Constructor
  ApiContactsService(String accessKey) : super(accessKey);

  @override
  Future<Response> createContact(String phoneNumber,
      {Map<String, dynamic> parameters}) {
    parameters['msisdn'] = phoneNumber;
    return post('/contacts', body: parameters);
  }

  @override
  Future<Response> deleteContact(String id) => delete('/contacts/$id');

  @override
  Future<Response> listContacts({int limit, int offset}) =>
      get('/contacts', body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> listGroupsOfContact(String contactId,
          {int limit, int offset}) =>
      get('/contacts/$contactId/groups',
          body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> listMesssagesForContact(String contactId,
          {int limit, int offset}) =>
      get('/contacts/$contactId/messages',
          body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> readContact(String id) => get('/contacts/$id');

  @override
  Future<Response> updateContact(int id, {Map<String, dynamic> parameters}) =>
      patch('/contacts/$id', body: parameters);
}
