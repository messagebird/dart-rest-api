import 'groups.dart';
import 'messages.dart';

/// Class encapsulating a [Contact] object.
class Contact {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  String id;

  /// The URL of the created [Contact].
  String href;

  /// The phone number of [Contact].
  String msisdn;

  /// The first name of the [Contact].
  String firstName;

  /// The last name of the [Contact].
  String lastName;

  /// Custom fields of the [Contact].
  List<String> custom;

  /// The groups the [Contact] belongs to.
  Groups groups;

  /// The messages sent to the [Contact].
  Messages messages;

  /// The date and time of the creation of the [Contact] in RFC3339 format (Y-m-d\TH:i:sP).
  DateTime createdDatetime;

  /// The date and time of the last update of the [Contact] in RFC3339 format (Y-m-d\TH:i:sP).
  DateTime updatedDatetime;

  /// Constructor.
  Contact(
      {this.id,
      this.href,
      this.msisdn,
      this.firstName,
      this.lastName,
      this.custom,
      this.groups,
      this.messages,
      this.createdDatetime,
      this.updatedDatetime});

  /// Construct a [Contact] object from a [json] object.
  factory Contact.fromJson(Map<String, dynamic> json) => (json == null)
      ? null
      : Contact(
          id: json['id'].toString(),
          href: json['href'].toString(),
          msisdn: json['msisdn'].toString(),
          firstName: json['firstName'].toString(),
          lastName: json['lastName'].toString(),
          custom: List<String>.from(json['custom']),
          groups: Groups.fromJson(json['groups']),
        );

  /// Get a list of [Contact] objects from a [json] object
  static List<Contact> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Contact.fromJson(j)).toList();
}
