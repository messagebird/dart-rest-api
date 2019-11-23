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
  Future<List<Conversation>> list({int limit, int offset}) async {
    final response = await get('/v1/conversations',
        hostname: BaseService.conversationsEndpoint,
        body: {'limit': limit, 'offset': offset});
    return Future.value(Conversation.fromJsonList(response.body));
  }

  @override
  Future<List<ConversationMessage>> listMessages(String contactId,
      {int limit, int offset}) async {
    final response = await get('/v1/conversations/$contactId/messages',
        hostname: BaseService.conversationsEndpoint,
        body: {'limit': limit, 'offset': offset});
    return Future.value(ConversationMessage.fromJsonList(response.body));
  }

  @override
  Future<Conversation> read(String id) async {
    final response = await get('/v1/conversations/$id',
        hostname: BaseService.conversationsEndpoint);
    return Future.value(Conversation.fromJson(response.body));
  }

  @override
  Future<ConversationMessage> readMessage(String id) async {
    final response = await get('/v1/messages/$id',
        hostname: BaseService.conversationsEndpoint);
    return Future.value(ConversationMessage.fromJson(response.body));
  }

  @override
  Future<Message> reply(String id, Message message) async {
    final response = await post('/v1/conversations/$id/messages',
        hostname: BaseService.conversationsEndpoint, body: message.toMap());
    return Future.value(Message.fromJson(response.body));
  }

  @override
  Future<MessageResponse> send(ConversationMessage message) async {
    final response = await post('/v1/send',
        hostname: BaseService.conversationsEndpoint, body: message.toMap());
    return Future.value(MessageResponse.fromJson(response.body));
  }

  @override
  Future<Conversation> start(ConversationMessage message) async {
    final response = await post('/v1/conversations/start',
        hostname: BaseService.conversationsEndpoint, body: message.toMap());
    return Future.value(Conversation.fromJson(response.body));
  }

  @override
  Future<Conversation> update(String id, ConversationStatus status) async {
    final Map<String, dynamic> j = {
      'status': status.toString().replaceAll('ConversationStatus.', '')
    };
    final response = await patch('/v1/conversations/$id',
        hostname: BaseService.conversationsEndpoint, body: j);
    return Future.value(Conversation.fromJson(response.body));
  }
}
