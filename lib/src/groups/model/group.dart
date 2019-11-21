import '../../contacts/model/contact.dart';
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
  Group(
      {this.id,
      this.name,
      this.href,
      this.contacts,
      this.createdDatetime,
      this.updatedDatetime});

  /// Construct a [Group] object from a [json] object.
  factory Group.fromJson(Map<String, dynamic> json) => (json == null)
      ? null
      : Group(
          id: json['id'].toString(),
          name: json['name'].toString(),
          href: json['href'].toString(),
          contacts: Contacts.fromJson(json['contacts']),
          createdDatetime: DateTime.parse(json['createdDatetime'].toString()),
          updatedDatetime: DateTime.parse(json['updatedDatetime'].toString()));

  /// Get a list of [Group] objects from a [json] object
  static List<Group> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Group.fromJson(j)).toList();

  /// Get a json object representing the [Contact]
  Map<String, dynamic> toJson() => {
        'id': id,
        'href': href,
        'name': name,
        'contacts': contacts.toJson(),
        'createdDatetime': createdDatetime.toIso8601String(),
        'updatedDatetime': updatedDatetime.toIso8601String()
      };
}
