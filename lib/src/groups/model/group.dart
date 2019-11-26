import 'dart:convert';

import 'package:messagebird_dart/src/general/util.dart';

import 'contacts.dart';

/// Class encapsulating a [Group] object.
class Group {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  final String id;

  /// The URL of the created object.
  final String href;

  /// The name of the group.
  final String name;

  /// The contacts in the group.
  final Contacts contacts;

  /// The date and time of the creation of the group in RFC3339 format
  /// (Y-m-d\TH:i:sP).
  final DateTime createdDatetime;

  /// The date and time of the last update of the group in RFC3339 format
  /// (Y-m-d\TH:i:sP).
  final DateTime updatedDatetime;

  /// Constructor.
  const Group({
    this.id,
    this.href,
    this.name,
    this.contacts,
    this.createdDatetime,
    this.updatedDatetime,
  });

  /// Construct a [Group] object from a json [String].
  factory Group.fromJson(String source) =>
      Group.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Group] object from a [Map].
  factory Group.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Group(
          id: map['id'],
          href: map['href'],
          name: map['name'],
          contacts: Contacts.fromMap(map['contacts']),
          createdDatetime: parseDate(map['createdDatetime']),
          updatedDatetime: parseDate(map['updatedDatetime']),
        );

  /// Get a json [String] representing the [Group].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'name': name,
        'contacts': contacts?.toMap(),
        'createdDatetime': createdDatetime?.toIso8601String(),
        'updatedDatetime': updatedDatetime?.toIso8601String(),
      };

  /// Get a list of [Group] objects from a json [String].
  static List<Group> fromJsonList(String source) => source == null
      ? null
      : json.decode(source)['totalCount'] == 0 ??
              json.decode(source)['pagination']['totalCount'] == 0
          ? <Group>[]
          : List.from(json.decode(source)['data'] ?? json.decode(source))
              .map((j) => Group.fromJson(j))
              .toList();
}
