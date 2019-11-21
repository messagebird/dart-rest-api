import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:messagebird_dart/src/conversations/model/conversation.dart';
import 'package:messagebird_dart/src/messages/model/message.dart';

import '../base_service.dart';
import 'conversations_service.dart';
import 'model/conversation_message.dart';
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
  Future<List<ConversationMessage>> listMessages(String contactId,
      {int limit, int offset}) async {
    final response = await get('/v1/conversations/$contactId/messages',
        hostname: BaseService.conversationsEndpoint,
        body: {'limit': limit, 'offset': offset});
    return Future.value(
        ConversationMessage.fromJsonList(json.decode(response.body)['data']));
  }

  @override
  Future<Conversation> read(String id) async {
    final response = await get('/v1/conversations/$id',
        hostname: BaseService.conversationsEndpoint);
    return Future.value(
        Conversation.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<ConversationMessage> readMessage(String id) async {
    final response = await get('/v1/messages/$id',
        hostname: BaseService.conversationsEndpoint);
    return Future.value(
        ConversationMessage.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<Message> reply(String id, Message message) async {
    final response = await post('/v1/conversations/$id/messages',
        hostname: BaseService.conversationsEndpoint, body: message.toJson());
    return Future.value(Message.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<MessageResponse> send(ConversationMessage message) async {
    final response = await post('/v1/send',
        hostname: BaseService.conversationsEndpoint, body: message.toJson());
    return Future.value(
        MessageResponse.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<Conversation> start(ConversationMessage message) async {
    final response = await post('/v1/conversations/start',
        hostname: BaseService.conversationsEndpoint, body: message.toJson());
    return Future.value(
        Conversation.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<Conversation> update(String id, ConversationStatus status) async {
    final Map<String, dynamic> j = {
      'status': status.toString().replaceAll('ConversationStatus.', '')
    };
    final response = await patch('/v1/conversations/$id',
        hostname: BaseService.conversationsEndpoint, body: j);
    return Future.value(
        Conversation.fromJson(json.decode(response.body)['data']));
  }
}
