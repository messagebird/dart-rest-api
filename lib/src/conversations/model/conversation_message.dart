import 'dart:convert';

import 'package:messagebird_dart/src/general/model/content.dart';
import 'package:messagebird_dart/src/general/model/message.dart';

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
      {MessageType type,
      Content content,
      String to,
      String from,
      String channelId,
      Map<String, dynamic> source,
      this.reportUrl,
      this.eventType,
      this.fallback})
      : super(
            type: type,
            content: content,
            to: to,
            from: from,
            channelId: channelId,
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
            type: type,
            content: map['content'] == null
                ? null
                : Content.fromMap(type, map['content']),
            from: map['from'],
            to: map['to'],
            channelId: map['channelId'],
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
        'type': type?.toString()?.replaceAll('MessageType.', ''),
        'content': content?.toMap(),
        'from': from,
        'to': to,
        'channelId': channelId,
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
