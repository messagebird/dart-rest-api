import 'dart:convert';

import 'phone_number.dart';

/// This object represents Numbers API your purshased phone numbers response.
class Numbers {
  /// The offset indicates number of results skipped.
  final int offset;

  /// The limit indicates the amount of results limited per page.
  final int limit;

  /// The number of phone numbers in the response.
  final int count;

  /// The number of phone numbers you own in total.
  final int totalCount;

  /// A list of phone numbers in the response, each of them is a [PhoneNumber]
  /// object
  final List<PhoneNumber> items;

  /// Constructor.
  const Numbers({
    this.offset,
    this.limit,
    this.count,
    this.totalCount,
    this.items,
  });

  /// Construct a [Numbers] object from a json [String].
  factory Numbers.fromJson(String source) =>
      Numbers.fromMap(json.decode(source));

  /// Construct a [Numbers] object from a [Map].
  factory Numbers.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Numbers(
          offset: map['offset'],
          limit: map['limit'],
          count: map['count'],
          totalCount: map['totalCount'],
          items: (map['count'] == 0)
              ? <PhoneNumber>[]
              : List<dynamic>.from(map['items'])
                  .map((j) => PhoneNumber.fromMap(j))
                  .toList());
}
