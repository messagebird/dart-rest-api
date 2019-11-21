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

  /// Constructor.
  Email(this.to, this.from, this.subject, this.content,
      {this.id,
      this.replyTo,
      this.returnPath,
      this.headers,
      this.attachments,
      this.tracking,
      this.reportUrl});

  /// Construct an [Email] object from a [json] object.
  factory Email.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Email(
          Recipient.fromJsonList(json['to']),
          Recipient.fromJson(json['from']),
          json['subject'].toString(),
          EmailContent.fromJson(json['content']),
          id: json['id'].toString(),
          replyTo: json['replyTo'].toString(),
          returnPath: json['returnPath'].toString(),
          headers: Map<String, String>.from(json['headers']),
          attachments: Attachment.fromJsonList(json['attachments']),
          tracking: Tracking.fromJson(json['tracking']),
          reportUrl: json['reportUrl'].toString());

  @override
  Map<String, dynamic> toJson() => {
        'to': to.map((recipient) => recipient.toJson()),
        'from': from.toJson(),
        'subject': subject,
        'content': content.toJson(),
        'id': id,
        'replyTo': replyTo,
        'returnPath': returnPath,
        'headers': headers,
        'attachments': attachments.map((attachment) => attachment.toJson()),
        'tracking': tracking.toJson(),
        'reportUrl': reportUrl
      };
}

/// The [EmailContent] object represents the content to be included as the body
/// of your message, it can contain either HTML or plain text.
class EmailContent extends Content {
  /// HTML content of the message, expected in UTF-8.
  String html;

  /// Plain text of the message, expected in UTF-8.
  String text;

  /// Constructor.
  EmailContent({this.html, this.text});

  /// Construct an [EmailContent] object from a [json] object.
  factory EmailContent.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : EmailContent(
          html: json['html'].toString(), text: json['text'].toString());

  /// Get a json object representing the [EmailContent]
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (html != null) {
      json.addAll({'html': html});
    }
    if (text != null) {
      json.addAll({'text': text});
    }
    return json;
  }
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
  Recipient(this.email, this.name, this.variables);

  /// Construct a [Recipient] object from a [json] object.
  factory Recipient.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Recipient(json['email'].toString(), json['name'],
          List<String>.from(json['custom']));

  /// Get a list of [Recipient] objects from a [json] object
  static List<Recipient> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Recipient.fromJson(j)).toList();

  /// Get a json object representing the [Recipient]
  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'variables': variables,
      };
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
  Attachment(this.name, this.type, this.data);

  /// Construct a [Attachment] object from a [json] object.
  factory Attachment.fromJson(Map<String, String> json) => json == null
      ? null
      : Attachment(json['name'].toString(), json['type'].toString(),
          json['data'].toString());

  /// Get a list of [Attachment] objects from a [json] object
  static List<Attachment> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Attachment.fromJson(j)).toList();

  /// Get a json object representing the [Attachment]
  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'data': data,
      };
}

/// Class encapsulating a [Tracking] object.
class Tracking {
  /// Adds a tracking pixel to handle `message.opened` events. (Default: true)
  bool open;

  /// Adds link-wrapping to handle `link.clicked` events. (Default: true)
  bool click;

  /// Constructor.
  Tracking({this.open = true, this.click = true});

  /// Construct a [Tracking] object from a [json] object.
  factory Tracking.fromJson(Map<String, String> json) => json == null
      ? null
      : Tracking(open: json['open'] == 'true', click: json['click'] == 'true');

  /// Get a json object representing the [Tracking]
  Map<String, dynamic> toJson() => {
        'open': open,
        'click': click,
      };
}
