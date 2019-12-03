/// Webhooks enable real-time notifications of conversation events to be
/// delivered to endpoints on your own server. A webhook can be configured with
/// a URL and a list of events that should be subscribed to for notifications.
/// It's possible to create multiple webhooks with different URLs to listen to
/// one or more events each.
library webhooks;

export 'src/webhooks/model/webhook.dart';
