import 'package:messagebird_dart/src/general/model/message.dart';

import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'messages_service.dart';

/// API implementation of messages service.
class ApiMessagesService extends BaseService implements MessagesService {
  /// Constructor.
  ApiMessagesService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Message> create(Message message) =>
      post('/messages', body: message.toMap())
          .then((response) => Future.value(Message.fromJson(response.body)));

  @override
  Future<Message> read(String id) =>
      get('/v1/messages/$id', hostname: BaseService.conversationsEndpoint)
          .then((response) => Future.value(Message.fromJson(response.body)));
}
