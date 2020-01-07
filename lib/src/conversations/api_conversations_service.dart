import '../general/model/base_service.dart';
import '../general/model/message.dart';
import '../webhooks/api_webhooks_service.dart';
import '../webhooks/webhooks_service.dart';
import 'conversations_service.dart';
import 'model/conversation.dart';
import 'model/conversation_message.dart';
import 'model/message_response.dart';

/// API implementation of [ConversationsService].
class ApiConversationsService extends BaseService
    implements ConversationsService {
  @override
  WebhooksService webhooks;

  /// Constructor.
  ApiConversationsService(String accessKey,
      {int timeout, List<String> features})
      : webhooks =
            ApiWebhooksService(accessKey, BaseService.conversationsEndpoint),
        super(accessKey, timeout: timeout, features: features);

  @override
  String getEndpoint() => BaseService.conversationsEndpoint;

  @override
  Future<List<Conversation>> list(
          {int limit,
          int offset,
          List<String> ids,
          ConversationStatus status}) =>
      get('/conversations', hostname: BaseService.conversationsEndpoint, body: {
        'limit': limit,
        'offset': offset,
        'ids': ids?.join(','),
        'status': status?.toString()?.replaceAll('ConversationStatus.', '')
      }).then((response) => Future.value(response?.body == null
          ? null
          : Conversation.fromJsonList(response.body)));

  @override
  Future<List<ConversationMessage>> listMessages(String id,
          {int limit, int offset}) =>
      get('/conversations/$id/messages',
              hostname: BaseService.conversationsEndpoint,
              body: {'limit': limit, 'offset': offset})
          .then((response) => Future.value(response?.body == null
              ? null
              : ConversationMessage.fromJsonList(response.body)));

  @override
  Future<Conversation> read(String id) =>
      get('/conversations/$id', hostname: BaseService.conversationsEndpoint)
          .then((response) => Future.value(response?.body == null
              ? null
              : Conversation.fromJson(response.body)));

  @override
  Future<ConversationMessage> readMessage(String id) =>
      get('/messages/$id', hostname: BaseService.conversationsEndpoint).then(
          (response) => Future.value(response == null
              ? null
              : ConversationMessage.fromJson(response.body)));

  @override
  Future<ConversationMessage> reply(String id, Message message) =>
      post('/conversations/$id/messages',
              hostname: BaseService.conversationsEndpoint,
              body: message.toMap())
          .then((response) => Future.value(response?.body == null
              ? null
              : ConversationMessage.fromJson(response.body)));

  @override
  Future<MessageResponse> send(ConversationMessage message) => post('/send',
          hostname: BaseService.conversationsEndpoint, body: message.toMap())
      .then((response) => Future.value(response?.body == null
          ? null
          : MessageResponse.fromJson(response.body)));

  @override
  Future<Conversation> start(ConversationMessage message) =>
      post('/conversations/start',
              hostname: BaseService.conversationsEndpoint,
              body: message.toMap())
          .then((response) => Future.value(response?.body == null
              ? null
              : Conversation.fromJson(response.body)));

  @override
  Future<Conversation> update(String id, ConversationStatus status) {
    final Map<String, dynamic> json = {
      'status': status.toString().replaceAll('ConversationStatus.', '')
    };
    return patch('/conversations/$id',
            hostname: BaseService.conversationsEndpoint, body: json)
        .then((response) => Future.value(response?.body == null
            ? null
            : Conversation.fromJson(response.body)));
  }
}
