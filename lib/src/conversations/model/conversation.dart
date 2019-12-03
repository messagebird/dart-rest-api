import 'dart:convert';

import '../../general/model/contact.dart';
import '../../util.dart';

import 'channel.dart';
import 'messages_count.dart';

/// Class encapsulating a [Conversation] object.
///
/// A [Conversation] is the view of all messages between the system and a
/// customer across any of the configured channels:
/// * Messages from multiple channels are collected and displayed in a single
/// conversation.
/// * When the first message is sent or received from a user, a conversation is
/// automatically created for them.
/// * A conversation status can be active or archived, but only one active
/// conversation exists for each customer at a time.
/// * Archiving can be used to end a conversation so that the next time that the
/// customer reaches out, a new conversation will be started. This is especially
/// helpful for support use cases where conversations need to be opened and
/// closed, rather than merely resumed.
class Conversation {
  /// A unique ID generated by the MessageBird platform that identifies this
  /// conversation.
  final String id;

  /// The MessageBird Contact for this conversation.
  final Contact contact;

  /// A series of Channels through which the contact of the conversation can be
  /// reached. This attribute can be empty if the conversation doesn't have any
  /// channels yet.
  final List<Channel> channels;

  /// The status of the conversation. See [ConversationStatus] for allowed
  /// values.
  final ConversationStatus status;

  /// A link to the messages of this conversation. See [MessagesCount] for
  /// definition.
  final MessagesCount messages;

  /// The date and time when this conversation was first created in RFC3339
  /// format.
  final DateTime createdDatetime;

  /// The date and time when this conversation was most recently updated in
  /// RFC3339 format. This applies only to changes of the Conversation object
  /// itself, not messages, i.e. currently just status changes.
  final DateTime updatedDatetime;

  /// The date and time when the most recent message was added to this
  /// conversation in RFC3339 format.
  final DateTime lastReceivedDatetime;

  /// A unique ID for the most recently used channel that sent or received a
  /// message in this conversation.
  final String lastUsedChannelId;

  /// Constructor.
  const Conversation({
    this.id,
    this.contact,
    this.channels,
    this.status,
    this.messages,
    this.createdDatetime,
    this.updatedDatetime,
    this.lastReceivedDatetime,
    this.lastUsedChannelId,
  });

  /// Construct a [Conversation] object from a json [String].
  factory Conversation.fromJson(String source) =>
      Conversation.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Conversation] object from a [Map].
  factory Conversation.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Conversation(
          id: map['id'],
          contact: Contact.fromMap(map['contact']),
          channels: List<Channel>.from(
              map['channels']?.map((channel) => Channel.fromMap(channel))),
          status: ConversationStatus.values.firstWhere(
              (status) =>
                  status.toString() == 'ConversationStatus.${map['status']}',
              orElse: () => null),
          messages: MessagesCount.fromMap(map['messages']),
          createdDatetime: parseDate(map['createdDatetime'].toString()),
          updatedDatetime: parseDate(map['updatedDatetime'].toString()),
          lastReceivedDatetime:
              parseDate(map['lastReceivedDatetime'].toString()),
          lastUsedChannelId: map['lastUsedChannelId'],
        );

  /// Get a json [String] representing the [Conversation].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'contact': contact?.toMap(),
        'channels':
            List<dynamic>.from(channels.map((channel) => channel.toMap())),
        'status': status?.toString()?.replaceAll('ConversationStatus.', ''),
        'messages': messages?.toMap(),
        'createdDatetime': createdDatetime?.toString(),
        'updatedDatetime': updatedDatetime?.toString(),
        'lastReceivedDatetime': lastReceivedDatetime?.toString(),
        'lastUsedChannelId': lastUsedChannelId,
      };

  /// Get a list of [Conversation] objects from a json [String].
  static List<Conversation> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Conversation>[]
          : List.from(json.decode(source)['items'] ?? json.decode(source))
              .map((j) => Conversation.fromMap(j))
              .toList();
}

/// Enumeration of [Conversation] statusses
enum ConversationStatus {
  /// [Conversation] is active.
  active,

  /// [Conversation] is archived.
  archived
}