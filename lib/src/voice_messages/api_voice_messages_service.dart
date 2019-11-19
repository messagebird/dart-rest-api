import 'package:http/http.dart' show Response;
import '../base_service.dart';
import 'voice_messages_service.dart';

/// API implementation of voice messages service
class ApiVoiceMessagesService extends BaseService
    implements VoiceMessagesService {
  /// Constructor
  ApiVoiceMessagesService(String accessKey) : super(accessKey);

  @override
  Future<Response> createVoiceMessage(
      List<String> recipients, Map<String, dynamic> parameters) {
    parameters['recipients'] = recipients.join(',');
    return post('/voicemessages');
  }

  @override
  Future<Response> readVoiceMessage(String id) => get('/voicemessages/$id');
}
