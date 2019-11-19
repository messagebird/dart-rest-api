import 'package:http/http.dart' show Response;

/// Webhooks service interface
abstract class WebhooksService {
  /// Creates a new webhook
  Future<Response> createWebhook(Map<String, dynamic> parameters);

  /// Retrieves an existing webhook by id
  Future<Response> readWebhook(String id);

  /// Updates a webhook
  Future<Response> updateWebhook(String id, Map<String, dynamic> parameters);

  /// Retieves a list of webhooks
  Future<Response> listWebhooks({int limit, int offset});

  /// Deletes webhook
  Future<Response> deleteWebhook(String id);
}
