/// [MessageBird's Verify API](https://developers.messagebird.com/api/verify/) enables you to verify a mobile phone number with
/// two-factor authentication. Create a new Verify object through the API to
/// start the verification process of a recipient. MessageBird will take care of
/// creating a token and making sure that the message gets delivered to the
/// provided number.
///
/// The Verify API uses `HTTP verbs` and a `RESTful` endpoint structure with an
/// access key that is used as the API Authorization. Request and response
/// payloads are formatted as JSON using UTF-8 encoding and URL encoded values.
library verify;

export 'src/verify/api_verify_service.dart';
export 'src/verify/model/verify.dart';
export 'src/verify/model/verify_response.dart';
export 'src/verify/verify_service.dart';
