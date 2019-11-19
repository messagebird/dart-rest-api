import 'package:http/http.dart' show Response;
import '../base_service.dart';
import 'messages_service.dart';

/// API implementation of messages service
class ApiMessagesService extends BaseService implements MessagesService {
  /// Constructor
  ApiMessagesService(String accessKey) : super(accessKey);

  @override
  Future<Response> createMessage(Map<String, dynamic> parameters) {
    if (parameters['recipients'] is List<String>) {
      parameters['recipients'] =
          List.castFrom(parameters['recipients']).join(',');
    }
    return post('/messages', body: parameters);
  }

  @override
  Future<Response> readMessage(String id) => get('/messages/$id');
}
