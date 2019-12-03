/// [MessageBird’s Voice Calling API](https://developers.messagebird.com/api/voice-calling/) enables VOIP features for your web
/// application to make, receive, and monitor voice calls from a MessageBird
/// voice-enabled virtual mobile number to and from any country around the world
/// through a REST API.
///
/// The Voice Calling API uses `HTTP verbs` and a `RESTful` endpoint structure
/// with an access key that is used as the API Authorization. Request and
/// response payloads are formatted as JSON using UTF-8 encoding and URL encoded
/// values.
library voice_calling;

// Callflows
export 'src/callflows/api_callflows_service.dart';
export 'src/callflows/callflows_service.dart';
export 'src/callflows/model/callflow.dart';
export 'src/callflows/model/step.dart';

// Calls
export 'src/calls/api_calls_service.dart';
export 'src/calls/calls_service.dart';
export 'src/calls/model/call.dart';
export 'src/calls/model/leg.dart';

// Recordings
export 'src/recordings/api_recordings_service.dart';
export 'src/recordings/model/recording.dart';
export 'src/recordings/recordings_service.dart';

// Transcriptions
export 'src/transcriptions/api_transcriptions_service.dart';
export 'src/transcriptions/model/transcription.dart';
export 'src/transcriptions/transcriptions_service.dart';

// Webhooks
export 'src/webhooks/api_webhooks_service.dart';
export 'src/webhooks/model/webhook.dart';
export 'src/webhooks/webhooks_service.dart';
