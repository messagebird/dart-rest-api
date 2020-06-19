import 'dart:io';

import 'package:messagebird/verify.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('VerifyService', () {
    String id;
    VerifyService verifyService;

    setUp(() {
      verifyService = ApiVerifyService(credentials.API_LIVE_KEY);
    });

    test('should request a verify', () {
      verifyService
          .create(
              Verify(recipient: credentials.MSISDN, originator: 'Drillster'))
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
  }, skip: !credentials.hasMSISDN || !credentials.arePresent);
}
