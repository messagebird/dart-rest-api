import 'dart:convert';

import 'contacts.dart';

/// Class encapsulating a [Group] object.
class Group {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  String id;

  /// The URL of the created object.
  String href;

  /// The name of the group.
  String name;

  /// The contacts in the group.
  Contacts contacts;

  /// The date and time of the creation of the group in RFC3339 format
  /// (Y-m-d\TH:i:sP).
  DateTime createdDatetime;

  /// The date and time of the last update of the group in RFC3339 format
  /// (Y-m-d\TH:i:sP).
  DateTime updatedDatetime;

  /// Constructor.
  Group({
    this.id,
    this.href,
    this.name,
    this.contacts,
    this.createdDatetime,
    this.updatedDatetime,
  });

  /// Construct a [Group] object from a json [String].
  factory Group.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return Group.fromMap(decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct a [Group] object from a [Map].
  factory Group.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Group(
          id: map['id'],
          href: map['href'],
          name: map['name'],
          contacts: Contacts.fromMap(map['contacts']),
          createdDatetime: DateTime.parse(map['createdDatetime'].toString()),
          updatedDatetime: DateTime.parse(map['updatedDatetime'].toString()),
        );

  /// Get a json [String] representing the [Group].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'name': name,
        'contacts': contacts.toMap(),
        'createdDatetime': createdDatetime.toIso8601String(),
        'updatedDatetime': updatedDatetime.toIso8601String(),
      };

  /// Get a list of [Group] objects from a json [String].
  static List<Group> fromJsonList(String source) => source == null
      ? null
      : List<String>.from(json.decode(source)['data'] ?? json.decode(source))
          .map((j) => Group.fromJson(j))
          .toList();
}
