/// The [MessageBird Numbers API](https://developers.messagebird.com/api/numbers/) gives you an
/// overview of all available MessageBird phone numbers and allows you to
/// purchase as well as manage all your phone numbers.
///
/// The Numbers API uses `HTTP verbs` and a `RESTful` endpoint structure with an
/// access key that is used as the API Authorization. Request and response
/// payloads are formatted as JSON using UTF-8 encoding and URL encoded values.
library numbers;

export 'src/numbers/api_numbers_service.dart';
export 'src/numbers/model/numbers.dart';
export 'src/numbers/model/phone_number.dart';
export 'src/numbers/model/recently_purchased_phone_number.dart';
export 'src/numbers/numbers_service.dart';
