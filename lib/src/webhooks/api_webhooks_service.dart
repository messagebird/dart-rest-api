import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'webhooks_service.dart';

/// API implementation of webhooks service.
class ApiWebhooksService extends BaseService implements WebhooksService {
  /// Constructor.
  ApiWebhooksService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(Map<String, dynamic> parameters) =>
      post('/v1/webhooks',
          hostname: BaseService.conversationsEndpoint, body: parameters);

  @override
  Future<Response> list({int limit, int offset}) => get('/v1/webhooks',
      hostname: BaseService.conversationsEndpoint,
      body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> read(String id) => get(
        '/v1/webhooks/$id',
        hostname: BaseService.conversationsEndpoint,
      );

  @override
  Future<Response> remove(String id) => delete(
        '/v1/webhooks/$id',
        hostname: BaseService.conversationsEndpoint,
      );

  @override
  Future<Response> update(String id, Map<String, dynamic> parameters) =>
      patch('/v1/webhooks',
          hostname: BaseService.conversationsEndpoint, body: parameters);
}
