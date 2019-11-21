import 'package:http/http.dart' show Response;

import 'model/conversation.dart';
import 'model/conversation_message.dart';
import 'model/message_response.dart';

/// Conversations service interface.
abstract class ConversationsService {
  /// Gets the API endpoint.
  String getEndpoint();

  /// Retrieves all conversations for this account. By default,
  /// conversations are sorted by their lastReceivedDatetime field so that
  /// conversations with new messages appear first.
  Future<Response> list(int limit, int offset);

  /// Lists the messages for a contact.
  Future<List<ConversationMessage>> listMessages(String contactId,
      {int limit, int offset});

  /// Retrieves a single conversation.
  Future<Conversation> read(String id);

  /// View a message
  Future<ConversationMessage> readMessage(String id);

  /// Adds a new message to an existing conversation and sends it to the
  /// contact that you're in conversation with.
  Future<Response> reply(String id, Map<String, String> parameters);

  /// Sends a new message to a channel-specific user identifier (e.g. phone
  /// number). If an active conversation already exists for the recipient,
  /// this conversation will be resumed. If an active conversation does not
  /// exist, a new one will be created.
  Future<MessageResponse> send(ConversationMessage message);

  /// Starts a new conversation from a channel-specific user identifier,
  /// such as a phone number, and sends a first message. If an active
  /// conversation already exists for the recipient, this conversation will
  /// be resumed.
  Future<Response> start(Map<String, dynamic> parameters);

  /// Update Conversation Status.
  Future<Conversation> update(String id, ConversationStatus status);
}
