import 'package:messagebird_dart/src/contacts/model/contact.dart';

import 'channel.dart';
import 'messages_count.dart';

class Conversation {
  String id;
  Contact contact;
  List<Channel> channels;
  ConversationStatus status;
  MessagesCount messages;
  DateTime createdDatetime;
  DateTime updatedDatetime;
  DateTime lastReceivedDatetime;
  String lastUsedChannelId;

  Conversation(
      this.id,
      this.contact,
      this.channels,
      this.status,
      this.messages,
      this.createdDatetime,
      this.updatedDatetime,
      this.lastReceivedDatetime,
      this.lastUsedChannelId);
}

enum ConversationStatus { active, archived }
