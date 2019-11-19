import 'package:http/http.dart' show Response;

/// Voice messages service interface.
abstract class VoiceMessagesService {
  /// Send a voice message.
  Future<Response> create(
      List<String> recipients, Map<String, dynamic> parameters);

  /// Get a voice message.
  Future<Response> read(String id);
}
