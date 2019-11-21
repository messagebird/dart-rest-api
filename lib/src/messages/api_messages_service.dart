import 'dart:convert';

import '../base_service.dart';
import 'messages_service.dart';
import 'model/message.dart';

/// API implementation of messages service.
class ApiMessagesService extends BaseService implements MessagesService {
  /// Constructor.
  ApiMessagesService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Message> create(Message message) async {
    final response = await post('/messages', body: message.toJson());
    return Future.value(Message.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<Message> read(String id) async {
    final response = await get('/v1/messages/$id',
        hostname: BaseService.conversationsEndpoint);
    return Future.value(Message.fromJson(json.decode(response.body)['data']));
  }
}
