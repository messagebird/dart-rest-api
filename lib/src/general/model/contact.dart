import 'dart:convert';

import '../util.dart';
import 'groups.dart';
import 'messages.dart';

/// Class encapsulating a [Contact] object.
class Contact {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  final String id;

  /// The URL of the created [Contact].
  final String href;

  /// The phone number of [Contact].
  final String msisdn;

  /// The first name of the [Contact].
  final String firstName;

  /// The last name of the [Contact].
  final String lastName;

  /// Custom fields of the [Contact].
  final Map<String, String> customDetails;

  /// The groups the [Contact] belongs to.
  final Groups groups;

  /// The messages sent to the [Contact].
  final Messages messages;

  /// The date and time of the creation of the [Contact] in RFC3339 format (Y-m-d\TH:i:sP).
  final DateTime createdDatetime;

  /// The date and time of the last update of the [Contact] in RFC3339 format (Y-m-d\TH:i:sP).
  final DateTime updatedDatetime;

  /// Constructor.
  const Contact(
      {this.id,
      this.href,
      this.msisdn,
      this.firstName,
      this.lastName,
      this.customDetails,
      this.groups,
      this.messages,
      this.createdDatetime,
      this.updatedDatetime});

  /// Construct a [Contact] object from a json [String].
  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source)['data'][0] ?? json.decode(source));

  /// Construct a [Contact] object from a [Map].
  factory Contact.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    } else {
      return Contact(
          id: map['id'].toString(),
          href: map['href'].toString(),
          msisdn: map['msisdn'].toString(),
          firstName: map['firstName'].toString(),
          lastName: map['lastName'].toString(),
          customDetails: map['customDetails'] == null
              ? null
              : Map<String, String>.from(map['customDetails']),
          groups: map['groups'] == null ? null : Groups.fromMap(map['groups']),
          messages: map['messages'] == null
              ? null
              : Messages.fromMap(map['messages']),
          createdDatetime: parseDate(map['createdDatetime']?.toString()),
          updatedDatetime: parseDate(map['updatedDatetime']?.toString()));
    }
  }

  /// Get a json [String] representing the [Contact].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'msisdn': msisdn,
        'firstName': firstName,
        'lastName': lastName,
        'customDetails': customDetails,
        'groups': groups?.toJson(),
        'messages': messages?.toJson(),
        'createdDatetime': createdDatetime?.toIso8601String(),
        'updatedDatetime': createdDatetime?.toIso8601String()
      };

  /// Get a list of [Contact] objects from a json [String]
  static List<Contact> fromJsonList(String source) {
    if (source == null) {
      return null;
    } else {
      return json.decode(source)['totalCount'] == 0
          ? <Contact>[]
          : List<dynamic>.from(json.decode(source)['items'])
              .map((j) => Contact.fromMap(j))
              .toList();
    }
  }
}
