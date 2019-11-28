import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'model/webhook.dart';
import 'webhooks_service.dart';

/// API implementation of webhooks service.
class ApiWebhooksService extends BaseService implements WebhooksService {
  /// Constructor.
  ApiWebhooksService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Webhook> create(Webhook webhook) => post('/v1/webhooks',
          hostname: BaseService.conversationsEndpoint, body: webhook.toMap())
      .then((response) => Future.value(Webhook.fromJson(response.body)));

  @override
  Future<List<Webhook>> list({int limit, int offset}) => get('/v1/webhooks',
          hostname: BaseService.conversationsEndpoint,
          body: {'limit': limit, 'offset': offset})
      .then((response) => Future.value(Webhook.fromJsonList(response.body)));

  @override
  Future<Webhook> read(String id) => get(
        '/v1/webhooks/$id',
        hostname: BaseService.conversationsEndpoint,
      ).then((response) => Future.value(
          response == null ? null : Webhook.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete(
        '/v1/webhooks/$id',
        hostname: BaseService.conversationsEndpoint,
      );

  @override
  Future<Webhook> update(Webhook webhook) => patch('/v1/webhooks/${webhook.id}',
          hostname: BaseService.conversationsEndpoint, body: webhook.toMap())
      .then((response) => Future.value(Webhook.fromJson(response.body)));
}
