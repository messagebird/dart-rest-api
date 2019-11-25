import 'model/webhook.dart';

/// Webhooks service interface.
abstract class WebhooksService {
  /// Creates a new webhook.
  Future<Webhook> create(Webhook webhook);

  /// Retieves a list of webhooks.
  Future<List<Webhook>> list({int limit, int offset});

  /// Retrieves an existing webhook by id.
  Future<Webhook> read(String id);

  /// Removes webhook.
  Future<void> remove(String id);

  /// Updates a webhook.
  Future<Webhook> update(Webhook webhook);
}
