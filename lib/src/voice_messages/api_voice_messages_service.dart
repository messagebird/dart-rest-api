import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'voice_messages_service.dart';

/// API implementation of voice messages service.
class ApiVoiceMessagesService extends BaseService
    implements VoiceMessagesService {
  /// Constructor.
  ApiVoiceMessagesService(String accessKey,
      {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(
      List<String> recipients, Map<String, dynamic> parameters) {
    parameters['recipients'] = recipients.join(',');
    return post('/voicemessages');
  }

  @override
  Future<Response> read(String id) => get('/voicemessages/$id');
}
