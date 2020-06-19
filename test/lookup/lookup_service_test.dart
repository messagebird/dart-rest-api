import 'dart:io';

import 'package:messagebird/lookup.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('LookupService', () {
    LookupService lookupService;

    setUp(() {
      lookupService = ApiLookupService(credentials.API_TEST_KEY);
    });

    test('should request a lookup', () {
      lookupService.read(credentials.MSISDN).then((lookup) {
        expect(lookup.countryPrefix, equals(31));
        expect(lookup.type, equals(LookupType.mobile));
      });
    });

    test('should request an HLR', () {
      lookupService.requestHlr(credentials.MSISDN).then((hlr) {
        expect(hlr.id, isNotNull);
      });
    });

    test('should read an HLR', () {
      lookupService.readHlr(credentials.MSISDN).then((hlr) {
        expect(hlr.id, isNotNull);
      });
    });
  }, skip: !credentials.hasMSISDN || !credentials.arePresent);
}
