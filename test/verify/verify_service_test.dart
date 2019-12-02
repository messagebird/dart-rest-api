import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
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

    test('should request a verify', () {
      verifyService
          .create(
              Verify(recipient: credentials['msisdn'], originator: 'Drillster'))
          .then((response) {
        expect(response.id, isNotNull);
        expect(response.status, equals(VerifyStatus.sent));
        id = response.id;
      });
    });

    test('should read a verify', () {
      verifyService.read(id).then((response) {
        expect(response.id, equals(id));
        expect(response.status, equals(VerifyStatus.sent));
      });
    });

    test('should verify a verification code', () {
      // Not testable, cannot get verification code.
    });

    test('should remove a verify', () {
      verifyService.remove(id);
      verifyService.read(id).then((response) {
        expect(response.status, equals(VerifyStatus.deleted));
      });
    });
  });
}
