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

  /// Construct a [ConversationMessage] object from a [json] object.
  factory ConversationMessage.fromJson(Map<String, dynamic> json) {
    final MessageType type = MessageType.values.firstWhere(
        (type) => type.toString() == 'MessageType.${json['type']}',
        orElse: () => null);

    return json == null
        ? null
        : ConversationMessage(
            to: json['to'].toString(),
            from: json['from'].toString(),
            type: type,
            content: Content.get(type, json['content']),
            reportUrl: json['reportUrl'].toString(),
            fallback: Fallback.fromJson(json['fallback']),
            source: json['source']);
  }

  /// Get a list of [ConversationMessage] objects from a [json] object
  static List<ConversationMessage> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => ConversationMessage.fromJson(j)).toList();

  /// Get a json object representing the [ConversationMessage]
  @override
  Map<String, dynamic> toJson() => {
        'to': to.toString(),
        'from': from.toString(),
        'type': type.toString().replaceAll('MessageType.', ''),
        'content': content.toJson(),
        'reportUrl': reportUrl.toString(),
        'fallback': fallback.toJson(),
        'source': source
      };
}
