/// The [MessageBird Conversations API](https://developers.messagebird.com/api/conversations/) is an omnichannel messaging solution to
/// unify sent and received messages across all of your chat channels in one
/// conversation thread. Conversations is the view of all messages between the
/// provider and customer across any configured channels-—SMS, WhatsApp,
/// WeChat, Messenger, Telegram, and LINE.
///
/// The Conversations API uses `HTTP verbs` and a `RESTful` endpoint structure
///  with an access key that is used as the API Authorization. Request and
/// response payloads are formatted as JSON using UTF-8 encoding and URL encoded
/// values.
library conversations;

export 'src/conversations/api_conversations_service.dart';
export 'src/conversations/conversations_service.dart';
export 'src/conversations/model/channel.dart';
export 'src/conversations/model/conversation.dart';
export 'src/conversations/model/conversation_message.dart';
export 'src/conversations/model/fallback.dart';
export 'src/conversations/model/message_response.dart';
export 'src/conversations/model/messages_count.dart';
export 'src/general/model/content.dart';
export 'src/general/model/email.dart';
export 'src/general/model/message.dart';
