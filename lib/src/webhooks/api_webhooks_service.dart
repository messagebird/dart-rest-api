import '../general/model/base_service.dart';
import 'model/webhook.dart';
import 'webhooks_service.dart';

/// API implementation of webhooks service.
class ApiWebhooksService extends BaseService implements WebhooksService {
  @override
  String endpoint;

  /// Constructor.
  ApiWebhooksService(String accessKey, this.endpoint,
      {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Webhook> create(Webhook webhook) =>
      post('/webhooks', hostname: endpoint, body: webhook.toMap()).then(
          (response) => Future.value(
              response?.body == null ? null : Webhook.fromJson(response.body)));

  @override
  Future<List<Webhook>> list({int limit, int offset}) => get('/webhooks',
          hostname: endpoint, body: {'limit': limit, 'offset': offset})
      .then((response) => Future.value(
          response?.body == null ? null : Webhook.fromJsonList(response.body)));

  @override
  Future<Webhook> read(String id) => get(
        '/webhooks/$id',
        hostname: endpoint,
      ).then((response) => Future.value(
          response?.body == null ? null : Webhook.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete(
        '/webhooks/$id',
        hostname: endpoint,
      );

  @override
  Future<Webhook> update(Webhook webhook) => patch('/webhooks/${webhook.id}',
          hostname: endpoint, body: webhook.toMap())
      .then((response) => Future.value(
          response?.body == null ? null : Webhook.fromJson(response.body)));
}
