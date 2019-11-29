import 'dart:io';
import 'package:messagebird_dart/src/webhooks/model/webhook.dart';
import 'package:test/test.dart';

void main() {
  group('Webhook', () {
    Webhook webhook;

    setUp(() {
      webhook = Webhook.fromJson(
          File('test_resources/recording.json').readAsStringSync());
    });

    test('should deserialize from json', () {});

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = webhook.toMap();
    });
  });
}
