/// [MessageBird's Voice Messaging API](https://developers.messagebird.com/api/voice-messaging/) enables you to transform text messages
/// into voice messages to any country. Each voice message is identified by a
/// unique random ID that can be used to check the status of the voice message.
/// You can select from 26 languages and different attributes such as male or
/// female voice, speaking rate, repeat, schedule, and more.
///
/// The Voice Messaging API uses `HTTP verbs` and a `RESTful` endpoint structure
/// with an access key that is used as the API Authorization framework. Request
/// and response payloads are formatted as JSON—although we provide a GET
/// alternative for requests—using UTF-8 encoding and URL encoded values.
library voice_messaging;

export 'src/voice_messages/api_voice_messages_service.dart';
export 'src/voice_messages/model/voice_message.dart';
export 'src/voice_messages/model/voice_message_response.dart';
export 'src/voice_messages/voice_messages_service.dart';
