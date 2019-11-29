import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
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

    test('should read a webhook', () async {});
  });
}
