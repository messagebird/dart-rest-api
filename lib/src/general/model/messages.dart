import 'dart:convert';

/// Class encapsulating a [Messages] object.
class Messages {
  /// The total count of messages sent to contact.
  int totalCount;

  /// URL which can be used to retrieve list of messages sent to contact.
  String href;

  /// Constructor.
  Messages({
    this.totalCount,
    this.href,
  });

  /// Construct a [Messages] object from a json [String].
  factory Messages.fromJson(String source) =>
      Messages.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Messages] object from a [Map].
  factory Messages.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Messages(
          totalCount: int.tryParse(map['totalCount'].toString()),
          href: map['href'],
        );

  /// Get a json [String] representing the [Messages].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'href': href,
      };
}
