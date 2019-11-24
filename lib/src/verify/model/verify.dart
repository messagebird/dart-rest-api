import 'dart:convert';

import 'package:messagebird_dart/src/contacts/model/messages.dart';

/// Class encapsulating a [Verify].
class Verify {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  final String id;

  /// The URL of the created object.
  final String href;

  /// The msisdn of the recipient.
  final int recipient;

  /// A client reference.
  final String reference;

  /// Referring the URL of the created object. The entry can either refer to
  /// either the `messages` or the `voicemessages` endpoint
  final Messages messages;

  /// The status of the verification. See [VerifyStatus] for allowed values.
  final VerifyStatus status;

  /// The date and time of the creation of the [Verify] object in RFC3339
  /// format (Y-m-d\TH:i:sP)
  final DateTime createdDatetime;

  /// The date and time indicating the expiration time of the [Verify] object in
  /// RFC3339 format (Y-m-d\TH:i:sP)
  final DateTime validUntilDatetime;

  /// Constructor.
  Verify({
    this.id,
    this.href,
    this.recipient,
    this.reference,
    this.messages,
    this.status,
    this.createdDatetime,
    this.validUntilDatetime,
  });

  /// Construct a [Verify] object from a json [String].
  factory Verify.fromJson(String source) =>
      Verify.fromMap(json.decode(source)['data'][0] ?? json.decode(source));

  /// Construct a [Verify] object from a [Map].
  factory Verify.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Verify(
          id: map['id'],
          href: map['href'],
          recipient: map['recipient'],
          reference: map['reference'],
          messages: Messages.fromMap(map['messages']),
          status: VerifyStatus.values.firstWhere(
              (status) => status.toString() == 'VerifyStatus.${map['status']}',
              orElse: () => null),
          createdDatetime: DateTime.parse(map['createdDatetime'].toString()),
          validUntilDatetime:
              DateTime.parse(map['validUntilDatetime'].toString()),
        );

  /// Get a json [String] representing the [Verify].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'recipient': recipient,
        'reference': reference,
        'messages': messages.toMap(),
        'status': status?.toString()?.replaceAll('VerifyStatus.', ''),
        'createdDatetime': createdDatetime.toIso8601String(),
        'validUntilDatetime': validUntilDatetime.toIso8601String(),
      };
}

/// Enumeration of the [Verify] statusses.
enum VerifyStatus {
  /// The verification request has been sent.
  sent,

  /// The verification request has expired.
  expired,

  /// The verification request has failed.
  failed,

  /// The number has been verified.
  verified,

  /// The verification request has been deleted.
  deleted
}
