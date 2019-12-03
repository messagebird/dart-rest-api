import 'dart:io';
import 'package:messagebird/webhooks.dart';
import 'package:test/test.dart';

void main() {
  group('Webhook', () {
    Webhook webhook;

    setUp(() {
      webhook = Webhook.fromJson(
          File('test_resources/webhook.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(webhook.id, equals('985ae50937a94c64b392531ea87a0263'));
      expect(webhook.status, equals(WebhookStatus.enabled));
      expect(webhook.events.length, equals(2));
      expect(webhook.updatedDatetime, isNull);
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = webhook.toMap();

      expect(serialized['id'], equals('985ae50937a94c64b392531ea87a0263'));
      expect(serialized['status'], equals('enabled'));
      expect(serialized['events'][0], equals('message.created'));
      expect(serialized['updatedDatetime'], isNull);
    });
  });
}
