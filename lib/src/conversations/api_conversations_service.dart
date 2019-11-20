import 'dart:convert';

import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'conversations_service.dart';
import 'model/message.dart';
import 'model/message_response.dart';

/// API implementation of [ConversationsService].
class ApiConversationsService extends BaseService
    implements ConversationsService {
  /// Constructor.
  ApiConversationsService(String accessKey,
      {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  String getEndpoint() => BaseService.conversationsEndpoint;

  @override
  Future<Response> list(int limit, int offset) => get('/v1/conversations',
      hostname: BaseService.conversationsEndpoint,
      body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> listMessages(String contactId, {int limit, int offset}) =>
      get('/v1/conversations/$contactId/messages',
          hostname: BaseService.conversationsEndpoint,
          body: {'limit': limit, 'offset': offset});

  @override
  Future<Response> read(String id) => get(
        '/v1/conversations/$id',
        hostname: BaseService.conversationsEndpoint,
      );

  @override
  Future<Response> readMessage(String id) => get(
        '/v1/messages/$id',
        hostname: BaseService.conversationsEndpoint,
      );

  @override
  Future<Response> reply(String id, Map<String, String> parameters) =>
      post('/v1/conversations/$id/messages',
          hostname: BaseService.conversationsEndpoint, body: parameters);

  @override
  Future<MessageResponse> send(Message message) async {
    final response = await post('/v1/send',
        hostname: BaseService.conversationsEndpoint, body: message.toJson());
    return Future.value(MessageResponse.fromJson(json.decode(response.body)));
  }

  @override
  Future<Response> start(Map<String, dynamic> parameters) =>
      post('/v1/conversations/start',
          hostname: BaseService.conversationsEndpoint, body: parameters);

  @override
  Future<Response> update(String id, String parameters) =>
      patch('/v1/conversations/$id',
          hostname: BaseService.conversationsEndpoint, body: parameters);
}
