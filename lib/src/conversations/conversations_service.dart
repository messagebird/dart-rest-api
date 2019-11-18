abstract class ConversationsService {
  String getEndpoint();

  Future<void> send(Map<String, dynamic> params);

  Future<void> start(Map<String, dynamic> params);

  Future<Object> list(int limit, int offset);

  Future<Object> read(String id);

  Future<void> update(String id, String params);

  Future<void> reply(String id, Object params);

  Future<Object> listMessages(String contactId, int limit, int offset);

  Future<Object> readMessage(String id);
}
