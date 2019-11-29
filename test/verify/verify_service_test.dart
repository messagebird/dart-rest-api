import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:test/test.dart';

void main() {
  group('VerifyService', () {
    Map credentials;
    String id;
    VerifyService verifyService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      verifyService = ApiVerifyService(credentials['live']);
    });

    test('should request a verify', () async {
      //await verifyService.create(Verify(recipient: 31617692626, ))
    });
  });
}
