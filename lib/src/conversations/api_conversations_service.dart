import 'package:messagebird_dart/src/base_service.dart';

import 'conversations_service.dart';

class ApiConversationsService extends BaseService
    implements ConversationsService {
  ApiConversationsService(String accessKey) : super(accessKey);

  @override
  String getEndpoint() {
    return BaseService.CONVERSATIONS_ENDPOINT;
  }

  @override
  Future<void> send(Map<String, dynamic> params) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'POST',
      'path': '/v1/send',
      'params': params
    });
  }

  @override
  Future<void> start(Map<String, dynamic> params) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'POST',
      'path': '/v1/conversations/start',
      'params': params
    });
  }

  @override
  Future<Object> list(int limit, int offset) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'GET',
      'path': '/v1/conversations',
      'params': {'limit': limit, 'offset': offset}
    });
  }

  @override
  Future<Object> listMessages(String contactId, int limit, int offset) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'GET',
      'path': '/v1/conversations/$contactId/messages',
      'params': {'limit': limit, 'offset': offset}
    });
  }

  @override
  Future<Object> read(String id) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'GET',
      'path': '/v1/conversations/$id',
    });
  }

  @override
  Future<Object> readMessage(String id) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'GET',
      'path': '/v1/messages/$id',
    });
  }

  @override
  Future<void> reply(String id, Object params) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'POST',
      'path': '/v1/conversations/$id/messages',
      'params': params
    });
  }

  @override
  Future<void> update(String id, String params) {
    return httpRequest({
      'hostname': BaseService.CONVERSATIONS_ENDPOINT,
      'method': 'PATCH',
      'path': '/v1/conversations/$id',
      'params': params
    });
  }
}
