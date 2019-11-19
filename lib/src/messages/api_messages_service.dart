import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'messages_service.dart';

/// API implementation of messages service.
class ApiMessagesService extends BaseService implements MessagesService {
  /// Constructor.
  ApiMessagesService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(Map<String, dynamic> parameters) {
    if (parameters['recipients'] is List<String>) {
      parameters['recipients'] =
          List.castFrom(parameters['recipients']).join(',');
    }
    return post('/messages', body: parameters);
  }

  @override
  Future<Response> read(String id) => get('/messages/$id');
}
