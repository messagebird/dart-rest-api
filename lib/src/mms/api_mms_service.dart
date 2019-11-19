import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'mms_service.dart';

/// API implementation of mms service
class ApiMmsService extends BaseService implements MmsService {
  /// Constructor
  ApiMmsService(String accessKey) : super(accessKey);

  @override
  Future<Response> createMmsMessage(Map<String, dynamic> parameters) {
    if (parameters['recipients'] is List<String>) {
      parameters['recipients'] = List.from(parameters['recipients']).join(',');
    }
    return post('/mms', body: parameters);
  }

  @override
  Future<Response> listMmsMessages({int limit, int offset}) =>
      get('/mms', body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> readMmsMessage(String id) => get('/mms/$id');

  @override
  Future<Response> deleteMmsMessage(String id) => delete('/mms/$id');
}
