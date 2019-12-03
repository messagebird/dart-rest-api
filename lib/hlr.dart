/// [MessageBird’s HLR API](https://developers.messagebird.com/api/hlr/) provides a way to send Network Queries to any mobile
/// number globally. It allows you to view what mobile number (MSISDN) belongs
/// to what operator in real-time and see if the number is active.
///
/// The HLR API uses `HTTP verbs` and a `RESTful` endpoint structure with an
/// access key that is used as the API Authorization framework. Request and
/// response payloads are formatted as JSON—although we provide a GET
/// alternative for requests—using UTF-8 encoding and URL encoded values.
library hlr;

export 'src/hlr/api_hlr_service.dart';
export 'src/hlr/hlr_service.dart';
export 'src/hlr/model/hlr.dart';
