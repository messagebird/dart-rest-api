import 'contact.dart';

/// Class encapsulating a list of [Calls].
class Contacts {
  /// Listing of all [Contacts].
  final List<Contact> contacts;

  /// Constructor.
  Contacts({this.contacts});

  /// Construct a [Contacts] object from a [json] object.
  factory Contacts.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Contacts(contacts: Contact.fromJsonList(json['data']));
}
