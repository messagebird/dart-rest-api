import 'package:messagebird_dart/src/general/model/message.dart';

/// Message service interface.
// ignore: one_member_abstracts
abstract class MessagesService {
  /// Get a text message.
  Future<Message> read(String id);
}
