import 'dart:developer';
import 'dart:io';

import 'package:messagebird/conversations.dart';
import 'package:messagebird/webhooks.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  group('WebhooksService', () {
    Credentials credentials;
    String id;
    ConversationsService conversationsService;

    setUp(() {
      credentials = Credentials.from(Platform.environment);
      conversationsService = ApiConversationsService(credentials.API_LIVE_KEY);
    });

    test('should create a webhook', () {
      conversationsService.webhooks
          .create(Webhook(
              events: [
            WebhookEvent.message_created,
            WebhookEvent.conversation_updated
          ],
              channelId: '619747f69cf940a98fb443140ce9aed2',
              url: 'https://example.com/webhook'))
          .then((webhook) {
        expect(webhook.id, isNotNull);
        expect(
            webhook.events,
            equals(
                [WebhookEvent.message_created, WebhookEvent.message_updated]));
        expect(webhook.channelId, equals('619747f69cf940a98fb443140ce9aed2'));
        expect(webhook.url, equals('https://example.com/webhook'));
        id = webhook.id;
      });
    });

    test('should read a webhook', () {
      conversationsService.webhooks.read(id).then((webhook) {
        expect(webhook.id, equals(id));
        expect(
            webhook.events,
            equals(
                [WebhookEvent.message_created, WebhookEvent.message_updated]));
        expect(webhook.channelId, equals('619747f69cf940a98fb443140ce9aed2'));
        expect(webhook.url, equals('https://example.com/webhook'));
      });
    });

    test('should list webhooks', () {
      conversationsService.webhooks.list().then((webhooks) {
        expect(webhooks, isNotEmpty);
        if (webhooks.length == 1) {
          expect(webhooks[0].id, equals(id));
          expect(
              webhooks[0].events,
              equals([
                WebhookEvent.message_created,
                WebhookEvent.message_updated
              ]));
          expect(webhooks[0].channelId,
              equals('619747f69cf940a98fb443140ce9aed2'));
          expect(webhooks[0].url, equals('https://example.com/webhook'));
        } else {
          log('There are more than one webhooks, cannot verify webhooks list');
        }
      });
    });

    test('should update a webhook', () {
      conversationsService.webhooks
          .update(Webhook(id: id, url: 'https://secondexample.com/webhook'))
          .then((updatedWebhook) {
        conversationsService.webhooks.read(id).then((readWebhook) {
          expect(readWebhook.url, equals(updatedWebhook.url));
        });
      });
    });

    test('should delete a webhook', () {
      conversationsService.webhooks.remove(id);
      conversationsService.webhooks.read(id).then((webhook) {
        expect(webhook, isNull);
      });
    });
  });
}
