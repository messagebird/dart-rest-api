import 'package:http/http.dart' show Response;

/// Webhooks service interface.
abstract class WebhooksService {
  /// Creates a new webhook.
  Future<Response> create(Map<String, dynamic> parameters);

  /// Retieves a list of webhooks.
  Future<Response> list({int limit, int offset});

  /// Retrieves an existing webhook by id.
  Future<Response> read(String id);

  /// Removes webhook.
  Future<Response> remove(String id);

  /// Updates a webhook.
  Future<Response> update(String id, Map<String, dynamic> parameters);
}
