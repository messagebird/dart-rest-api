/// Class encapsulating a [Contacts] object.
class Contacts {
  /// The total count of messages sent to contact.
  int totalCount;

  /// URL which can be used to retrieve list of messages sent to contact.
  String href;

  /// Constructor.
  Contacts({this.totalCount, this.href});

  /// Construct a [Contacts] object from a [json] object.
  factory Contacts.fromJson(Map<String, dynamic> json) => (json == null)
      ? null
      : Contacts(
          totalCount: int.parse(json['totalCount']),
          href: json['href'].toString());

  /// Get a json object representing the [Contacts]
  Map<String, dynamic> toJson() => {'totalCount': totalCount, 'href': href};
}
