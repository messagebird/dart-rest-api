import 'dart:convert';

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

  /// Construct a [Contact] object from a json [String].
  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source)['data']);

  /// Construct a [Contact] object from a [Map].
  factory Contact.fromMap(Map<String, dynamic> map) => (map == null)
      ? null
      : Contact(
          id: map['id'].toString(),
          href: map['href'].toString(),
          msisdn: map['msisdn'].toString(),
          firstName: map['firstName'].toString(),
          lastName: map['lastName'].toString(),
          custom: List<String>.from(map['custom']),
          groups: Groups.fromJson(map['groups']),
          messages: Messages.fromJson(map['messages']),
          createdDatetime: DateTime.parse(map['createdDatetime'].toString()),
          updatedDatetime: DateTime.parse(map['updatedDatetime'].toString()));

  /// Get a json [String] representing the [Contact].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'msisdn': msisdn,
        'firstName': firstName,
        'lastName': lastName,
        'custom': custom,
        'groups': groups.toJson(),
        'messages': messages.toJson(),
        'createdDatetime': createdDatetime.toIso8601String(),
        'updatedDatetime': createdDatetime.toIso8601String()
      };

  /// Get a list of [Contact] objects from a [json] String
  static List<Contact> fromJsonList(String source) => source == null
      ? null
      : List.from(json.decode(source)['data'])
          .map((j) => Contact.fromJson(j))
          .toList();
}
