import 'dart:convert';

/// Class encapsulating a [Groups] object.
class Groups {
  /// The total count of groups that contact belongs to.
  int totalCount;

  /// URL which can be used to retrieve list of groups contact belongs to.
  String href;

  /// Constructor.
  Groups({
    this.totalCount,
    this.href,
  });

  /// Construct an [Groups] object from a json [String].
  factory Groups.fromJson(String source) =>
      Groups.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Groups] object from a [Map].
  factory Groups.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Groups(
          totalCount: int.tryParse(map['totalCount'].toString()),
          href: map['href'],
        );

  /// Get a json [String] representing the [Groups].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'href': href,
      };
}
