import 'dart:convert';

import 'package:messagebird_dart/src/general/model/messages.dart';
import 'package:messagebird_dart/src/general/util.dart';

/// Class encapsulating a [VerifyResponse].
class VerifyResponse {
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

  /// The date and time of the creation of the [VerifyResponse] object in
  /// RFC3339 format (Y-m-d\TH:i:sP)
  final DateTime createdDatetime;

  /// The date and time indicating the expiration time of the [VerifyResponse]
  /// object in RFC3339 format (Y-m-d\TH:i:sP)
  final DateTime validUntilDatetime;

  /// Constructor.
  VerifyResponse({
    this.id,
    this.href,
    this.recipient,
    this.reference,
    this.messages,
    this.status,
    this.createdDatetime,
    this.validUntilDatetime,
  });

  /// Construct a [VerifyResponse] object from a json [String].
  factory VerifyResponse.fromJson(String source) =>
      VerifyResponse.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [VerifyResponse] object from a [Map].
  factory VerifyResponse.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : VerifyResponse(
          id: map['id'],
          href: map['href'],
          recipient: map['recipient'],
          reference: map['reference'],
          messages: Messages.fromMap(map['messages']),
          status: VerifyStatus.values.firstWhere(
              (status) => status.toString() == 'VerifyStatus.${map['status']}',
              orElse: () => null),
          createdDatetime: parseDate(map['createdDatetime']),
          validUntilDatetime: parseDate(map['validUntilDatetime']),
        );
}

/// Enumeration of the [VerifyResponse] statusses.
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
