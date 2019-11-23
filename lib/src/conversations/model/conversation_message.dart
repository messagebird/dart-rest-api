import 'dart:convert';

import 'package:messagebird_dart/src/messages/model/content.dart';

import '../../messages/model/message.dart';
import 'fallback.dart';

/// Class encapsulating a [ConversationMessage] object.
class ConversationMessage extends Message {
  /// The URL for delivery of status reports for the message. Must be HTTPS.
  String reportUrl;

  /// Parameters required to send a Fallback message if the primary delivery
  /// fails.
  Fallback fallback;

  /// Constructor.
  ConversationMessage(
      {String to,
      String from,
      MessageType type,
      Content content,
      this.reportUrl,
      this.fallback,
      Map<String, dynamic> source})
      : super(to: to, from: from, type: type, content: content, source: source);

  /// Construct a [ConversationMessage] object from a json [String].
  factory ConversationMessage.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return ConversationMessage.fromMap(
        decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct a [ConversationMessage] object from a [Map].
  factory ConversationMessage.fromMap(Map<String, dynamic> map) {
    final MessageType type = MessageType.values.firstWhere(
        (type) => type.toString() == 'MessageType.${map['type']}',
        orElse: () => null);

    return map == null
        ? null
        : ConversationMessage(
            to: map['to'].toString(),
            from: map['from'].toString(),
            type: type,
            content: Content.get(type, map['content']),
            reportUrl: map['reportUrl'].toString(),
            fallback: Fallback.fromJson(map['fallback']),
            source: map['source']);
  }

  /// Get a json [String] representing the [ConversationMessage].
  @override
  String toJson() => json.encode(toMap());

  /// Get a json object representing the [ConversationMessage]
  @override
  Map<String, dynamic> toMap() => {
        'to': to.toString(),
        'from': from.toString(),
        'type': type.toString().replaceAll('MessageType.', ''),
        'content': content.toJson(),
        'reportUrl': reportUrl.toString(),
        'fallback': fallback.toJson(),
        'source': source
      };

  /// Get a list of [ConversationMessage] objects from a json [String].
  static List<ConversationMessage> fromJsonList(String source) => source == null
      ? null
      : List.from(json.decode(source)['data'] ?? json.decode(source))
          .map((j) => ConversationMessage.fromJson(j))
          .toList();
}
