import 'package:http/http.dart' show Response;

/// Voice messages service interface
abstract class VoiceMessagesService {
  /// Get a voice message
  Future<Response> readVoiceMessage(String id);

  /// Send a voice message
  Future<Response> createVoiceMessage(
      List<String> recipients, Map<String, dynamic> parameters);
}
