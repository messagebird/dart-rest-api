import 'package:messagebird_dart/src/general/model/message.dart';

import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'conversations_service.dart';
import 'model/conversation.dart';
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
  Future<List<Conversation>> list({int limit, int offset}) => get(
          '/v1/conversations',
          hostname: BaseService.conversationsEndpoint,
          body: {'limit': limit, 'offset': offset})
      .then(
          (response) => Future.value(Conversation.fromJsonList(response.body)));

  @override
  Future<List<ConversationMessage>> listMessages(String id,
          {int limit, int offset}) =>
      get('/v1/conversations/$id/messages',
              hostname: BaseService.conversationsEndpoint,
              body: {'limit': limit, 'offset': offset})
          .then((response) =>
              Future.value(ConversationMessage.fromJsonList(response.body)));

  @override
  Future<Conversation> read(String id) =>
      get('/v1/conversations/$id', hostname: BaseService.conversationsEndpoint)
          .then((response) => Future.value(
              response == null ? null : Conversation.fromJson(response.body)));

  @override
  Future<ConversationMessage> readMessage(String id) =>
      get('/v1/messages/$id', hostname: BaseService.conversationsEndpoint).then(
          (response) => Future.value(response == null
              ? null
              : ConversationMessage.fromJson(response.body)));

  @override
  Future<Message> reply(String id, Message message) =>
      post('/v1/conversations/$id/messages',
              hostname: BaseService.conversationsEndpoint,
              body: message.toMap())
          .then((response) => Future.value(Message.fromJson(response.body)));

  @override
  Future<MessageResponse> send(ConversationMessage message) => post('/v1/send',
          hostname: BaseService.conversationsEndpoint, body: message.toMap())
      .then(
          (response) => Future.value(MessageResponse.fromJson(response.body)));

  @override
  Future<Conversation> start(ConversationMessage message) => post(
          '/v1/conversations/start',
          hostname: BaseService.conversationsEndpoint,
          body: message.toMap())
      .then((response) => Future.value(Conversation.fromJson(response.body)));

  @override
  Future<Conversation> update(String id, ConversationStatus status) {
    final Map<String, dynamic> json = {
      'status': status.toString().replaceAll('ConversationStatus.', '')
    };
    return patch('/v1/conversations/$id',
            hostname: BaseService.conversationsEndpoint, body: json)
        .then((response) => Future.value(Conversation.fromJson(response.body)));
  }
}
