import 'dart:convert';

import 'package:messagebird/src/util.dart';

import '../../general/model/content.dart';
import '../../general/model/message.dart';

import 'fallback.dart';

/// Class encapsulating a [ConversationMessage] object.
class ConversationMessage extends Message {
  /// The URL for delivery of status reports for the message. Must be HTTPS.
  final String reportUrl;

  /// Parameters required to send a Fallback message if the primary delivery
  /// fails.
  final Fallback fallback;

  /// The type of event message being posted, to be able to send that field, the
  /// value of the parameter `type` must be a `event`.
  final String eventType;

  /// Constructor.
  const ConversationMessage(
      {String id,
      String conversationId,
      String channelId,
      String platform,
      String to,
      String from,
      MessageDirection direction,
      MessageStatus status,
      MessageType type,
      Content content,
      DateTime createdDatetime,
      DateTime updatedDatetime,
      Map<String, dynamic> source,
      this.reportUrl,
      this.eventType,
      this.fallback})
      : super(
            id: id,
            conversationId: conversationId,
            channelId: channelId,
            platform: platform,
            to: to,
            from: from,
            direction: direction,
            status: status,
            type: type,
            content: content,
            createdDatetime: createdDatetime,
            updatedDatetime: updatedDatetime,
            source: source);

  /// Construct a [ConversationMessage] object from a json [String].
  factory ConversationMessage.fromJson(String source) =>
      ConversationMessage.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [ConversationMessage] object from a [Map].
  factory ConversationMessage.fromMap(Map<String, dynamic> map) {
    final MessageType type = MessageType.values.firstWhere(
        (type) => type.toString() == 'MessageType.${map['type']}',
        orElse: () => null);

    return map == null
        ? null
        : ConversationMessage(
            id: map['id'],
            conversationId: map['conversationId'],
            channelId: map['channelId'],
            platform: map['platform'],
            from: map['from'],
            to: map['to'],
            direction: MessageDirection.values.firstWhere(
                (direction) =>
                    direction.toString() ==
                    'MessageDirection.${map['direction']}',
                orElse: () => null),
            status: MessageStatus.values.firstWhere(
                (status) =>
                    status.toString() == 'MessageStatus.${map['status']}',
                orElse: () => null),
            type: type,
            content: map['content'] == null
                ? null
                : Content.fromMap(type, map['content']),
            createdDatetime: parseDate(map['createdDatetime']),
            updatedDatetime: parseDate(map['updatedDatetime']),
            source: map['source'],
            reportUrl: map['reportUrl'],
            eventType: map['eventType'],
            fallback: map['fallback'] == null
                ? null
                : Fallback.fromMap(map['fallback']));
  }

  /// Get a json [String] representing the [ConversationMessage].
  @override
  String toJson() => json.encode(toMap());

  /// Get a json object representing the [ConversationMessage]
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'conversationId': conversationId,
        'channelId': channelId,
        'platform': platform,
        'to': to,
        'from': from,
        'direction': direction?.toString()?.replaceAll('MessageDirection.', ''),
        'status': status?.toString()?.replaceAll('MessageStatus.', ''),
        'type': type?.toString()?.replaceAll('MessageType.', ''),
        'content': content.toMap(),
        'createdDatetime': createdDatetime?.toString(),
        'updatedDatetime': updatedDatetime?.toString(),
        'source': source,
        'reportUrl': reportUrl,
        'eventType': eventType,
        'fallback': fallback?.toMap(),
      };

  /// Get a list of [ConversationMessage] objects from a json [String].
  static List<ConversationMessage> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <ConversationMessage>[]
          : List.from(json.decode(source)['items'])
              .map((j) => ConversationMessage.fromMap(j))
              .toList();
}
