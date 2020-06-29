import 'dart:convert';

import '../../util.dart';
import 'phone_number.dart';

/// This object represents a recently purchased phone number.
class RecentlyPurchasedPhoneNumber extends PhoneNumber {
  /// Created timestamp eg. "2019-04-25T14:04:04Z".
  final DateTime createdAt;

  /// Renewal timestamp eg. "2019-05-25T00:00:00Z".
  final DateTime renewalAt;

  /// Constructor.
  RecentlyPurchasedPhoneNumber(
    number,
    country,
    region,
    locality,
    features,
    tags,
    type,
    status,
    this.createdAt,
    this.renewalAt,
  ) : super(
            number: number,
            country: country,
            region: region,
            locality: locality,
            features: features,
            tags: tags,
            type: type,
            status: status);

  /// Construct a [RecentlyPurchasedPhoneNumber] object from a json [String].
  factory RecentlyPurchasedPhoneNumber.fromJson(String source) =>
      RecentlyPurchasedPhoneNumber.fromMap(json.decode(source));

  /// Construct a [RecentlyPurchasedPhoneNumber] object from a [Map].
  factory RecentlyPurchasedPhoneNumber.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

    final phoneNumber = PhoneNumber.fromMap(map);

    return RecentlyPurchasedPhoneNumber(
      phoneNumber.number,
      phoneNumber.country,
      phoneNumber.region,
      phoneNumber.locality,
      phoneNumber.features,
      phoneNumber.tags,
      phoneNumber.type,
      phoneNumber.status,
      parseDate(map['createdAt']),
      parseDate(map['renewalAt']),
    );
  }
}
