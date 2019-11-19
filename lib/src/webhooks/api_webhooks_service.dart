import 'package:http/http.dart' show Response;
import '../base_service.dart';
import 'webhooks_service.dart';

/// API implementation of webhooks service
class ApiWebhooksService extends BaseService implements WebhooksService {
  /// Constructor
  ApiWebhooksService(String accessKey) : super(accessKey);

  @override
  Future<Response> createWebhook(Map<String, dynamic> parameters) =>
      post('/v1/webhooks',
          hostname: BaseService.conversationsEndpoint, body: parameters);

  @override
  Future<Response> deleteWebhook(String id) => delete(
        '/v1/webhooks/$id',
        hostname: BaseService.conversationsEndpoint,
      );

  @override
  Future<Response> listWebhooks({int limit, int offset}) => get('/v1/webhooks',
      hostname: BaseService.conversationsEndpoint,
      body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> readWebhook(String id) => get(
        '/v1/webhooks/$id',
        hostname: BaseService.conversationsEndpoint,
      );

  @override
  Future<Response> updateWebhook(String id, Map<String, dynamic> parameters) =>
      patch('/v1/webhooks',
          hostname: BaseService.conversationsEndpoint, body: parameters);
}
