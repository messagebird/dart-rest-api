import 'package:http/http.dart' show Response;

/// Message service interface.
abstract class MessagesService {
  /// Sends a text message.
  Future<Response> create(Map<String, dynamic> parameters);

  /// Get a text message.
  Future<Response> read(String id);
}
