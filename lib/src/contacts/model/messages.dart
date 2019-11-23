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
  factory Messages.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return Messages.fromMap(decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct a [Messages] object from a [Map].
  factory Messages.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Messages(
          totalCount: int.parse(map['totalCount'].toString()),
          href: map['href'].toString(),
        );

  /// Get a json [String] representing the [Messages].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'href': href,
      };
}
