/// [MessageBird's Lookup API](https://developers.messagebird.com/api/lookup/) enables you to validate and look up a mobile
/// number. You supply our API with the phone numbers you’d like to check, our
/// API performs an HLR Lookup on the mobile network and identifies the number
/// format, and we fill in the number data, along with availability and
/// provider. The Lookup API will help you keep your database clean.
///
/// A phone number validation will tell you if the specified phone number looks
/// valid. It will also include some alternative formats to display the phone
/// number in. An HLR lookup allows you to view which mobile number (MSISDN)
/// belongs to what operator in real-time and see whether the number is active.
///
/// The Lookup API uses `HTTP verbs` and a `RESTful` endpoint structure with an
/// access key that is used as the API Authorization framework. Request and
/// response payloads are formatted as JSON—although we provide a GET
/// alternative for requests—using UTF-8 encoding and URL encoded values.
library lookup;

export 'src/lookup/api_lookup_service.dart';
export 'src/lookup/lookup_service.dart';
export 'src/lookup/model/lookup.dart';
