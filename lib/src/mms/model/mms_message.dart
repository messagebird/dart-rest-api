import 'dart:convert';

import 'recipients.dart';

/// Class encapsulating a [MmsMessage].
class MmsMessage {
  /// A unique ID which is created on the MessageBird platform and is returned
  /// upon creation of the object.
  String id;

  /// The URL of the created object.
  String href;

  /// Tells you if the message is sent or received.
  ///
  /// `mt`: mobile terminated (sent to mobile)
  ///
  /// `mo`: mobile originated (received from mobile)
  String direction;

  /// The sender/source address of the message. This has to be the dedicated MMS
  /// virtual mobile number (including country code) for either the US/CA.
  String originator;

  /// An object containing recipient information. See [Recipients] for details.
  Recipients recipients;

  /// The subject of the MMS message.
  String subject;

  /// The body of the MMS message.
  String body;

  /// An array with URL's to the media attachments you want to send as part of
  /// the MMS message.
  List<String> mediaUrls;

  /// A client reference.
  String reference;

  /// The scheduled date and time of the message in RFC3339 format
  /// (Y-m-d\TH:i:sP)
  DateTime scheduledDatetime;

  /// The date and time of the creation of the message in RFC3339 format
  /// (Y-m-d\TH:i:sP)
  DateTime createdDatetime;

  /// Constructor.
  MmsMessage({
    this.id,
    this.href,
    this.direction,
    this.originator,
    this.recipients,
    this.subject,
    this.body,
    this.mediaUrls,
    this.reference,
    this.scheduledDatetime,
    this.createdDatetime,
  });

  /// Construct an [MmsMessage] object from a json [String].
  factory MmsMessage.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return MmsMessage.fromMap(
        decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct an [MmsMessage] object from a [Map].
  factory MmsMessage.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : MmsMessage(
          id: map['id'],
          href: map['href'],
          direction: map['direction'],
          originator: map['originator'],
          recipients: Recipients.fromMap(map['recipients']),
          subject: map['subject'],
          body: map['body'],
          mediaUrls: List<String>.from(map['mediaUrls']),
          reference: map['reference'],
          scheduledDatetime: DateTime.parse(map['scheduledDatetime']),
          createdDatetime: DateTime.parse(map['createdDatetime']),
        );

  /// Get a json [String] representing the [MmsMessage]
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'direction': direction,
        'originator': originator,
        'recipients': recipients.toMap(),
        'subject': subject,
        'body': body,
        'mediaUrls': mediaUrls,
        'reference': reference,
        'scheduledDatetime': scheduledDatetime.toIso8601String(),
        'createdDatetime': createdDatetime.toIso8601String(),
      };

  /// Get a list of [MmsMessage] objects from a json [String].
  static List<MmsMessage> fromJsonList(String source) => source == null
      ? null
      : List.from(json.decode(source)['data'] ?? json.decode(source))
          .map((j) => MmsMessage.fromJson(j))
          .toList();
}
