import 'package:http/http.dart' show Response;

/// Conversations service interface
abstract class ConversationsService {
  /// Gets the API endpoint
  String getEndpoint();

  /// Sends a new message to a channel-specific user identifier (e.g. phone
  /// number). If an active conversation already exists for the recipient,
  /// this conversation will be resumed. If an active conversation does not
  /// exist, a new one will be created.
  Future<Response> sendMesssage(Map<String, dynamic> parameters);

  /// Starts a new conversation from a channel-specific user identifier,
  /// such as a phone number, and sends a first message. If an active
  /// conversation already exists for the recipient, this conversation will
  /// be resumed.
  Future<Response> startConversation(Map<String, dynamic> parameters);

  /// Retrieves all conversations for this account. By default,
  /// conversations are sorted by their lastReceivedDatetime field so that
  /// conversations with new messages appear first.
  Future<Response> listConversations(int limit, int offset);

  /// Retrieves a single conversation.
  Future<Response> readConversation(String id);

  /// Update Conversation Status.
  Future<Response> updateConversation(String id, String parameters);

  /// Adds a new message to an existing conversation and sends it to the
  /// contact that you're in conversation with.
  Future<Response> reply(String id, Map<String, String> parameters);

  /// Lists the messages for a contact.
  Future<Response> listMessages(String contactId, {int limit, int offset});

  /// View a message
  Future<Response> readMessage(String id);
}
