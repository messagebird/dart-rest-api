/// [MessageBird's MMS API](https://developers.messagebird.com/api/mms-messaging/) enables you to send and receive MMS messages that
/// include multimedia content to and from a selected group of countries.
/// Currently, you can only send MMS within the US and Canada.
///
/// Messages are identified by a unique ID. And with this ID you can always
/// check the status of the MMS message through the provided endpoint.
///
/// The MMS API uses `HTTP verbs` and a `RESTful` endpoint structure with an
/// access key that is used as the API Authorization framework. Request and
/// response payloads are formatted as JSON—although we provide a GET
/// alternative for requests—using UTF-8 encoding and URL encoded values.
library mms;

export 'src/mms/api_mms_service.dart';
export 'src/mms/mms_service.dart';
export 'src/mms/model/mms_message.dart';
export 'src/mms/model/recipients.dart';
