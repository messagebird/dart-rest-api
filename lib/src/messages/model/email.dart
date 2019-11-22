import 'dart:convert';

import 'content.dart';

/// Class encapsulating an [Email] object.
///
/// The email object is the same as used by the [Email API](https://developers.messagebird.com/api/email). The required fields
/// are `to`, `from`, `subject` and `content`.
class Email extends Content {
  /// A unique random ID for this message on the MessageBird platform, returned
  /// upon acceptance of the message.
  String id;

  /// Required. A List containing of all the recipients of the message.
  List<Recipient> to;

  /// Required. Name / address that will be displayed in the from field of the
  /// sent messages, the domain in the address email must be registered to one
  /// of the channels in the MessageBird account.
  Recipient from;

  /// Required. This will be displayed as the subject in the message, expected
  /// in the UTF-8 charset without RFC2047 encoding.
  String subject;

  /// Required. HTML or text content for the email. At least one type of content
  /// is required.
  EmailContent content;

  /// Email address used to compose the email’s “Reply-To” header.
  String replyTo;

  /// Email address used to compose the email’s “Return-Path” header. Must match
  /// the sending domain of the MessageBird account.
  String returnPath;

  /// Object containing custom headers other than Subject, From, To, and
  /// Reply-To. These will be sent along with the message.
  Map<String, String> headers;

  /// List of the attachments of the message.
  List<Attachment> attachments;

  /// Optional. Allows for tracking options.
  Tracking tracking;

  /// The URL for delivery of status reports for the message. Must use https.
  String reportUrl;

  /// Constructor
  Email({
    this.id,
    this.to,
    this.from,
    this.subject,
    this.replyTo,
    this.headers,
    this.attachments,
    this.tracking,
    this.reportUrl,
  });

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'to': List<dynamic>.from(to.map((recipient) => recipient.toMap())),
        'from': from.toMap(),
        'subject': subject,
        'replyTo': replyTo,
        'headers': headers,
        'attachments': List<dynamic>.from(
            attachments.map((attachment) => attachment.toMap())),
        'tracking': tracking.toMap(),
        'reportUrl': reportUrl,
      };

  @override
  String toJson() => json.encode(toMap());
}

/// The [EmailContent] object represents the content to be included as the body
/// of your message, it can contain either HTML or plain text.
class EmailContent extends Content {
  /// HTML content of the message, expected in UTF-8.
  String html;

  /// Plain text of the message, expected in UTF-8.
  String text;

  /// Constructor.
  EmailContent({
    this.html,
    this.text,
  });

  @override
  Map<String, dynamic> toMap() => {
        'html': html,
        'text': text,
      };

  @override
  String toJson() => json.encode(toMap());
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
  String email;

  /// Name attached to the email address, this appears in the To field in a
  /// users email client.
  String name;

  /// List of variables used for placeholders inside the content or headers of
  /// your email.
  List<String> variables;

  /// Constructor.
  Recipient({
    this.email,
    this.name,
    this.variables,
  });

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'email': email,
        'name': name,
        'variables': List<String>.from(variables.map((variable) => variable)),
      };

  /// Construct a [Recipient] object from a [Map].
  factory Recipient.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Recipient(
          email: map['email'],
          name: map['name'],
          variables: List<String>.from(map['variables']),
        );

  /// Get a json [String] representing the [Recipient].
  String toJson() => json.encode(toMap());

  /// Construct an [Recipient] object from a json [String].
  factory Recipient.fromJson(String source) =>
      Recipient.fromMap(json.decode(source));
}

/// Class encapsulating an [Attachment] object.
class Attachment {
  /// The filename of the attachment. This is inserted into the filename
  /// parameter of the Content-Disposition header. Maximum length is 255
  /// characters.
  String name;

  /// The MIME type of the attachment. The value will apply as-is to the
  /// Content-Type header of the generated MIME part for the attachment. Include
  /// the charset parameter, if needed (e.g. text/html; charset="UTF-8")
  String type;

  /// The content of the attachment as a Base64 encoded string. The string
  /// should not contain \r\n line breaks.
  String data;

  /// Constructor.
  Attachment({
    this.name,
    this.type,
    this.data,
  });

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type,
        'data': data,
      };

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

  /// Construct an [Attachment] object from a json [String].
  factory Attachment.fromJson(String source) =>
      Attachment.fromMap(json.decode(source));

  /// Get a list of [Attachment] objects from a [json] object
  static List<Attachment> fromList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Attachment.fromJson(j)).toList();
}

/// Class encapsulating a [Tracking] object.
class Tracking {
  /// Adds a tracking pixel to handle `message.opened` events. (Default: true)
  bool open;

  /// Adds link-wrapping to handle `link.clicked` events. (Default: true)
  bool click;

  /// Constructor.
  Tracking({
    this.open,
    this.click,
  });

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'open': open,
        'click': click,
      };

  /// Construct a [Tracking] object from a [Map].
  factory Tracking.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Tracking(
          open: map['open'],
          click: map['click'],
        );

  /// Get a json [String] representing the [Tracking] object.
  String toJson() => json.encode(toMap());

  /// Construct a [Tracking] object from a json [String].
  factory Tracking.fromJson(String source) =>
      Tracking.fromMap(json.decode(source));
}
