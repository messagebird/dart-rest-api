import 'dart:convert';

import 'content.dart';

/// Class encapsulating an [Attachment] object.
class Attachment {
  /// The filename of the attachment. This is inserted into the filename
  /// parameter of the Content-Disposition header. Maximum length is 255
  /// characters.
  final String name;

  /// The MIME type of the attachment. The value will apply as-is to the
  /// Content-Type header of the generated MIME part for the attachment. Include
  /// the charset parameter, if needed (e.g. text/html; charset="UTF-8")
  final String type;

  /// The content of the attachment as a Base64 encoded string. The string
  /// should not contain \r\n line breaks.
  final String data;

  /// Constructor.
  const Attachment({
    this.name,
    this.type,
    this.data,
  });

  /// Construct an [Attachment] object from a json [String].
  factory Attachment.fromJson(String source) =>
      Attachment.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct an [Attachment] object from a [Map].
  factory Attachment.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Attachment(
          name: map['name'],
          type: map['type'],
          data: map['data'],
        );

  /// Get a json [String] representing the [Attachment].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type,
        'data': data,
      };

  /// Get a list of [Attachment] objects from a json [String].
  static List<Attachment> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Attachment>[]
          : List<dynamic>.from(json.decode(source)['items'])
              .map((j) => Attachment.fromMap(j))
              .toList();
}

/// Class encapsulating an [Email] object.
///
/// The email object is the same as used by the [Email API](https://developers.messagebird.com/api/email). The required fields
/// are `to`, `from`, `subject` and `content`.
class Email extends Content {
  /// A unique random ID for this message on the MessageBird platform, returned
  /// upon acceptance of the message.
  final String id;

  /// Required. A List containing of all the recipients of the message.
  final List<Recipient> to;

  /// Required. Name / address that will be displayed in the from field of the
  /// sent messages, the domain in the address email must be registered to one
  /// of the channels in the MessageBird account.
  final Recipient from;

  /// Required. This will be displayed as the subject in the message, expected
  /// in the UTF-8 charset without RFC2047 encoding.
  final String subject;

  /// Required. HTML or text content for the email. At least one type of content
  /// is required.
  final EmailContent content;

  /// Email address used to compose the email’s “Reply-To” header.
  final String replyTo;

  /// Email address used to compose the email’s “Return-Path” header. Must match
  /// the sending domain of the MessageBird account.
  final String returnPath;

  /// Object containing custom headers other than Subject, From, To, and
  /// Reply-To. These will be sent along with the message.
  final Map<String, String> headers;

  /// List of the attachments of the message.
  final List<Attachment> attachments;

  /// Optional. Allows for tracking options.
  final Tracking tracking;

  /// The URL for delivery of status reports for the message. Must use https.
  final String reportUrl;

  /// Constructor
  const Email({
    this.id,
    this.to,
    this.from,
    this.subject,
    this.content,
    this.replyTo,
    this.returnPath,
    this.headers,
    this.attachments,
    this.tracking,
    this.reportUrl,
  });

  /// Construct an [Email] object from a json [String].
  factory Email.fromJson(String source) =>
      Email.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct an [Email] object from a [Map].
  factory Email.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Email(
          id: map['id'],
          to: map['to'] == null
              ? null
              : List<Recipient>.from(
                  map['to'].map((recipient) => Recipient.fromMap(recipient))),
          from: Recipient.fromMap(map['from']),
          subject: map['subject'],
          content: EmailContent.fromMap(map['content']),
          replyTo: map['replyTo'],
          returnPath: map['returnPath'],
          headers: map['headers'],
          attachments: Attachment.fromJsonList(map['attachments']),
          tracking: Tracking.fromMap(map['tracking']),
          reportUrl: map['reportUrl']);

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'to': List<dynamic>.from(to.map((recipient) => recipient.toMap())),
        'from': from.toMap(),
        'subject': subject,
        'content': content.toMap(),
        'replyTo': replyTo,
        'returnPath': returnPath,
        'headers': headers,
        'attachments': attachments == null
            ? null
            : List<dynamic>.from(
                attachments.map((attachment) => attachment.toMap())),
        'tracking': tracking?.toMap(),
        'reportUrl': reportUrl,
      };
}

/// The [EmailContent] object represents the content to be included as the body
/// of your message, it can contain either HTML or plain text.
class EmailContent extends Content {
  /// HTML content of the message, expected in UTF-8.
  final String html;

  /// Plain text of the message, expected in UTF-8.
  final String text;

  /// Constructor.
  const EmailContent({
    this.html,
    this.text,
  });

  /// Construct an [EmailContent] object from a json [String].
  factory EmailContent.fromJson(String source) =>
      EmailContent.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct an [EmailContent] object from a [Map].
  factory EmailContent.fromMap(Map<String, dynamic> map) =>
      map == null ? null : EmailContent(html: map['html'], text: map['text']);

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        'html': html,
        'text': text,
      };
}

/// Class encapsulating a [Recipient] object.
///
/// The recipients of an email can be specified as a List of Recipient objects
/// with the properties listed below. Variables added for each recipient are
/// used to customise the content sent to a user if a template with matching
/// dynamic placeholders is used in the body or custom headers. Additional
/// variables not present in the content or headers are ignored.
class Recipient {
  /// Required. Valid email address.
  final String email;

  /// Name attached to the email address, this appears in the To field in a
  /// users email client.
  final String name;

  /// Map of variables used for placeholders inside the content or headers of
  /// your email.
  final Map<String, dynamic> variables;

  /// Constructor.
  const Recipient({
    this.email,
    this.name,
    this.variables,
  });

  /// Construct an [Recipient] object from a json [String].
  factory Recipient.fromJson(String source) =>
      Recipient.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Recipient] object from a [Map].
  factory Recipient.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Recipient(
          email: map['email'],
          name: map['name'],
          variables: map['variables'],
        );

  /// Get a json [String] representing the [Recipient].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'email': email,
        'name': name,
        'variables': variables,
      };

  /// Get a list of [Attachment] objects from a json [String].
  static List<Recipient> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Recipient>[]
          : List<dynamic>.from(json.decode(source)['items'])
              .map((j) => Recipient.fromMap(j))
              .toList();
}

/// Class encapsulating a [Tracking] object.
class Tracking {
  /// Adds a tracking pixel to handle `message.opened` events. (Default: true)
  final bool open;

  /// Adds link-wrapping to handle `link.clicked` events. (Default: true)
  final bool click;

  /// Constructor.
  const Tracking({
    this.open,
    this.click,
  });

  /// Construct a [Tracking] object from a json [String].
  factory Tracking.fromJson(String source) =>
      Tracking.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Tracking] object from a [Map].
  factory Tracking.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Tracking(
          open: map['open'] == 'true',
          click: map['click'] == 'true',
        );

  /// Get a json [String] representing the [Tracking] object.
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'open': open,
        'click': click,
      };
}
