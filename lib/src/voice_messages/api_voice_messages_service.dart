import '../general/model/base_service.dart';
import 'model/voice_message.dart';
import 'model/voice_message_response.dart';
import 'voice_messages_service.dart';

/// API implementation of voice messages service.
class ApiVoiceMessagesService extends BaseService
    implements VoiceMessagesService {
  /// Constructor.
  ApiVoiceMessagesService(String accessKey,
      {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<VoiceMessageResponse> create(VoiceMessage message) =>
      post('/voicemessages', body: message.toMap()).then((response) =>
          Future.value(VoiceMessageResponse.fromJson(response.body)));

  @override
  Future<VoiceMessageResponse> read(String id) =>
      get('/voicemessages/$id').then((response) => Future.value(response == null
          ? null
          : VoiceMessageResponse.fromJson(response.body)));
}
