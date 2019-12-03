import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:messagebird/voice_calling.dart';
import 'package:test/test.dart';

void main() {
  group('WebhooksService', () {
    Map credentials;
    String id;
    WebhooksService webhooksService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      webhooksService = ApiWebhooksService(credentials['live']);
    });

    test('should create a webhook', () {
      webhooksService
          .create(Webhook(
              events: ['message.created', 'message.updated'],
              channelId: '619747f69cf940a98fb443140ce9aed2',
              url: 'https://example.com/webhook'))
          .then((webhook) {
        expect(webhook.id, isNotNull);
        expect(webhook.events, equals(['message.created', 'message.updated']));
        expect(webhook.channelId, equals('619747f69cf940a98fb443140ce9aed2'));
        expect(webhook.url, equals('https://example.com/webhook'));
        id = webhook.id;
      });
    });

    test('should read a webhook', () {
      webhooksService.read(id).then((webhook) {
        expect(webhook.id, equals(id));
        expect(webhook.events, equals(['message.created', 'message.updated']));
        expect(webhook.channelId, equals('619747f69cf940a98fb443140ce9aed2'));
        expect(webhook.url, equals('https://example.com/webhook'));
      });
    });

    test('should list webhooks', () {
      webhooksService.list().then((webhooks) {
        expect(webhooks, isNotEmpty);
        if (webhooks.length == 1) {
          expect(webhooks[0].id, equals(id));
          expect(webhooks[0].events,
              equals(['message.created', 'message.updated']));
          expect(webhooks[0].channelId,
              equals('619747f69cf940a98fb443140ce9aed2'));
          expect(webhooks[0].url, equals('https://example.com/webhook'));
        } else {
          log('There are more than one webhooks, cannot verify webhooks list');
        }
      });
    });

    test('should update a webhook', () {
      webhooksService
          .update(Webhook(id: id, url: 'https://secondexample.com/webhook'))
          .then((updatedWebhook) {
        webhooksService.read(id).then((readWebhook) {
          expect(readWebhook.url, equals(updatedWebhook.url));
        });
      });
    });

    test('should delete a webhook', () {
      webhooksService.remove(id);
      webhooksService.read(id).then((webhook) {
        expect(webhook, isNull);
      });
    });
  });
}
