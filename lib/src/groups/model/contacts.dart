import 'dart:convert';

/// Class encapsulating a [Contacts] object.
class Contacts {
  /// The total count of messages sent to contact.
  int totalCount;

  /// URL which can be used to retrieve list of messages sent to contact.
  String href;

  /// Constructor.
  Contacts({
    this.totalCount,
    this.href,
  });

  /// Construct a [Contacts] object from a json [String].
  factory Contacts.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return Contacts.fromMap(decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct a [Contacts] object from a [Map].
  factory Contacts.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Contacts(
          totalCount: int.parse(map['totalCount'].toString()),
          href: map['href'].toString(),
        );

  /// Get a json [String] representing the [Contacts].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'href': href,
      };
}
