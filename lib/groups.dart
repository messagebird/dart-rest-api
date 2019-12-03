/// [MessageBird’s Groups API](https://developers.messagebird.com/api/groups/) allows you to manage contact groups that are
/// identified by a unique random ID. Use this ID to create, view, update or
/// delete groups.
///
/// The Groups API uses `HTTP verbs` and a `RESTful` endpoint structure with an
///  access key that is used as the API Authorization framework. Request and
/// response payloads are formatted as JSON — although we provide a GET
/// alternative for requests — using UTF-8 encoding and URL encoded values.
library groups;

export 'src/groups/api_groups_service.dart';
export 'src/groups/groups_service.dart';
export 'src/groups/model/contacts.dart';
export 'src/groups/model/group.dart';
