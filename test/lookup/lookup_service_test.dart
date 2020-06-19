import 'dart:io';

import 'package:messagebird/lookup.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  group('LookupService', () {
    Credentials credentials;
    LookupService lookupService;

    setUp(() {
      credentials = Credentials.from(Platform.environment);
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
  });
}
