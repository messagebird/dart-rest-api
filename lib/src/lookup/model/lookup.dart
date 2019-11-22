import '../../hlr/model/hlr.dart';

/// Class encapsulating a [Lookup] object.
class Lookup {
  /// The URL of this lookup.
  String href;

  /// The country code for this number in ISO 3166-1 alpha-2 format.
  String countryCode;

  /// The country calling code for this number.
  int countryPrefix;

  /// The phone number in E.164 format without the prefixed plus-sign.
  int phoneNumber;

  /// The type of number. See [LookupType] for allowed values.
  LookupType type;

  /// References to this phone number in several different formats.
  Map<String, String> formats;

  /// The most recent HLR object. If no such HLR objects exists, this object
  /// won't be returned.
  Hlr hlr;

  /// Constructor.
  Lookup(
      {this.href,
      this.countryCode,
      this.countryPrefix,
      this.phoneNumber,
      this.type,
      this.formats,
      this.hlr});

  /// Construct an [Lookup] object from a [json] object.
  factory Lookup.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Lookup(
          href: json['href'].toString(),
          countryCode: json['countryCode'].toString(),
          countryPrefix: int.parse(json['countryPrefix']),
          phoneNumber: int.parse(json['phoneNumber']),
          type: LookupType.values.firstWhere(
              (status) => status.toString() == 'LookupType.${json['status']}',
              orElse: () => LookupType.unknown),
          formats: Map<String, String>.from(json['formats']),
          hlr: Hlr.fromJson(json['hlr']));
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
