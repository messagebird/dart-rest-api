import 'content.dart';
import 'fallback.dart';

class Message {
  String to;
  String from;
  String type;
  Content content;
  String reportUrl;
  Fallback fallback;
  Map<String, dynamic> source;

  Message(
      {this.to,
      this.from,
      this.type,
      this.content,
      this.reportUrl,
      this.fallback,
      this.source});

  factory Message.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Message(
          to: json['to'].toString(),
          from: json['from'].toString(),
          type: json['type'].toString(),
          content: Content.values.firstWhere(
              (content) => content.toString() == 'Content.${json['content']}',
              orElse: () => null),
          reportUrl: json['reportUrl'].toString(),
          fallback: Fallback.fromJson(json['fallback']),
          source: json['source']);

  Map<String, dynamic> toJson() => {
        'to': to,
        'from': from,
        'type': type,
        'content': content,
        'reportUrl': reportUrl,
        'fallback': fallback,
        'source': source
      };
}
