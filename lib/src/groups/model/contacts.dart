import 'dart:convert';

/// Class encapsulating a [Contacts] object.
class Contacts {
  /// The total count of messages sent to contact.
  final int totalCount;

  /// URL which can be used to retrieve list of messages sent to contact.
  final String href;

  /// Constructor.
  const Contacts({
    this.totalCount,
    this.href,
  });

  /// Construct a [Contacts] object from a json [String].
  factory Contacts.fromJson(String source) =>
      Contacts.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Contacts] object from a [Map].
  factory Contacts.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Contacts(
          totalCount: int.tryParse(map['totalCount'].toString()),
          href: map['href'],
        );

  /// Get a json [String] representing the [Contacts].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'totalCount': totalCount,
        'href': href,
      };
}
