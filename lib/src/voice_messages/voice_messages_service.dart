import 'model/voice_message.dart';

/// Voice messages service interface.
abstract class VoiceMessagesService {
  /// Send a voice message.
  Future<VoiceMessage> create(VoiceMessage message);

  /// Get a voice message.
  Future<VoiceMessage> read(String id);
}
