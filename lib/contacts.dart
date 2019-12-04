/// [MessageBird’s Contacts API](https://developers.messagebird.com/api/contacts/) helps you manage contacts that are identified by
/// a unique random ID. Using this ID, you can create, view, update, or delete
/// contacts. This API works as a collection of customer-specific contacts that
/// allows you to group them and assign custom values that you can later use
/// when sending SMS template messages.
///
/// The Contacts API uses `HTTP verbs` and a `RESTful` endpoint structure with
///  an access key that is used as the API Authorization. Request and response
/// payloads are formatted as JSON using UTF-8 encoding and URL encoded values.
library contacts;

export 'src/contacts/api_contacts_service.dart';
export 'src/contacts/contacts_service.dart';
export 'src/general/model/contact.dart';
export 'src/general/model/groups.dart';
export 'src/general/model/messages.dart';
