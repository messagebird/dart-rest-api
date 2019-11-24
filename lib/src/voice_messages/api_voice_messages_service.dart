import '../base_service.dart';
import 'model/voice_message.dart';
import 'voice_messages_service.dart';

/// API implementation of voice messages service.
class ApiVoiceMessagesService extends BaseService
    implements VoiceMessagesService {
  /// Constructor.
  ApiVoiceMessagesService(String accessKey,
      {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<VoiceMessage> create(VoiceMessage message) => post('/voicemessages')
      .then((response) => Future.value(VoiceMessage.fromJson(response.body)));

  @override
  Future<VoiceMessage> read(String id) => get('/voicemessages/$id')
      .then((response) => Future.value(VoiceMessage.fromJson(response.body)));
}
