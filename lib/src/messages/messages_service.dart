import 'package:http/http.dart' show Response;

/// Message service interface
abstract class MessagesService {
  /// Get a text message
  Future<Response> readMessage(String id);

  /// Sends a text message
  Future<Response> createMessage(Map<String, dynamic> parameters);
}
