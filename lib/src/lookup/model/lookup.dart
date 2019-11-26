import 'dart:convert';

import '../../hlr/model/hlr.dart';

/// Class encapsulating a [Lookup] object.
class Lookup {
  /// The URL of this lookup.
  final String href;

  /// The country code for this number in ISO 3166-1 alpha-2 format.
  final String countryCode;

  /// The country calling code for this number.
  final int countryPrefix;

  /// The phone number in E.164 format without the prefixed plus-sign.
  final int phoneNumber;

  /// The type of number. See [LookupType] for allowed values.
  final LookupType type;

  /// References to this phone number in several different formats.
  final Map<String, String> formats;

  /// The most recent HLR object. If no such HLR objects exists, this object
  /// won't be returned.
  final Hlr hlr;

  /// Constructor.
  const Lookup({
    this.href,
    this.countryCode,
    this.countryPrefix,
    this.phoneNumber,
    this.type,
    this.formats,
    this.hlr,
  });

  /// Construct a [Lookup] object from a json [String].
  factory Lookup.fromJson(String source) =>
      Lookup.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Lookup] object from a [Map].
  factory Lookup.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Lookup(
          href: map['href'],
          countryCode: map['countryCode'],
          countryPrefix: int.parse(map['countryPrefix'].toString()),
          phoneNumber: int.parse(map['phoneNumber'].toString()),
          type: LookupType.values.firstWhere(
              (status) =>
                  status.toString() ==
                  'LookupType.${map['type'].toString().replaceAll(' ', '_')}',
              orElse: () => LookupType.unknown),
          formats: Map<String, String>.from(map['formats']),
          hlr: Hlr.fromMap(map['hlr']),
        );

  /// Get a json [String] representing the [Lookup].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'href': href,
        'countryCode': countryCode,
        'countryPrefix': countryPrefix,
        'phoneNumber': phoneNumber,
        'type':
            type.toString().replaceAll('LookupType.', '').replaceAll('_', ' '),
        'formats': formats,
        'hlr': hlr.toMap(),
      };
}

/// Enumeration of [Lookup] types.
enum LookupType {
  /// The number is fixed line.
  // ignore: constant_identifier_names
  fixed_line,

  /// The number is mobile.
  mobile,

  /// The number is either fixed line or mobile.
  // ignore: constant_identifier_names
  fixed_line_or_mobile,

  /// The number is toll free.
  // ignore: constant_identifier_names
  toll_free,

  /// The number is premium rate.
  // ignore: constant_identifier_names
  premium_rate,

  /// The number is shared cost.
  // ignore: constant_identifier_names
  shared_cost,

  /// The number is voip.
  voip,

  /// The number is personal.
  // ignore: constant_identifier_names
  personal_number,

  /// The number is from a pager.
  pager,

  /// The number is a universal access number.
  // ignore: constant_identifier_names
  universal_access_number,

  /// The number is voice mail.
  // ignore: constant_identifier_names
  voice_mail,

  /// The type of number is unknown.
  unknown
}
