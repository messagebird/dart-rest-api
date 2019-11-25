import 'package:messagebird_dart/src/general/model/message.dart';

/// Message service interface.
abstract class MessagesService {
  /// Sends a text message.
  Future<Message> create(Message message);

  /// Get a text message.
  Future<Message> read(String id);
}
