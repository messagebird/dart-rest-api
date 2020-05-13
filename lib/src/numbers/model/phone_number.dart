import 'dart:convert';

/// This object represents a phone number.
class PhoneNumber {
  /// The number of a phone number eg. 31612345670.
  final String number;

  /// The Alpha-2 country code eg. NL.
  final String country;

  /// The registered region eg. Texel
  final String region;

  /// The locality eg. Texel.
  final String locality;

  /// The list of features of a phone number. Possible values: `sms`, `voice`, `mms`.
  final List<String> features;

  /// The list of tags added to the phone number.
  final List<String> tags;

  /// The type of a phone number. Possible values: `landline`, `mobile`, `premium_rate`.
  final String type;

  /// The status of a phone number.
  final String status;

  /// Constructor
  const PhoneNumber({
    this.number,
    this.country,
    this.region,
    this.locality,
    this.features,
    this.tags,
    this.type,
    this.status,
  });

  /// Construct a [PhoneNumber] object from a json [String].
  factory PhoneNumber.fromJson(String source) =>
      PhoneNumber.fromMap(json.decode(source));

  /// Construct a [PhoneNumber] object from a [Map].
  factory PhoneNumber.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : PhoneNumber(
          number: map['number'],
          country: map['country'],
          region: map['region'],
          locality: map['locality'],
          features: List<String>.from(map['features']),
          tags: List<String>.from(map['tags']),
          type: map['type'],
          status: map['status'],
        );
}
