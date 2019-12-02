import 'model/voice_message.dart';
import 'model/voice_message_response.dart';

/// Voice messages service interface.
abstract class VoiceMessagesService {
  /// Send a voice message.
  Future<VoiceMessageResponse> create(VoiceMessage message);

  /// Get a voice message.
  Future<VoiceMessageResponse> read(String id);
}
