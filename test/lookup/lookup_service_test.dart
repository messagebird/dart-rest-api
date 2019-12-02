import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('LookupService', () {
    Map credentials;
    LookupService lookupService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      lookupService = ApiLookupService(credentials['test']);
    });

    test('should request a lookup', () {
      lookupService.read(credentials['msisdn']).then((lookup) {
        expect(lookup.countryPrefix, equals(31));
        expect(lookup.type, equals(LookupType.mobile));
      });
    });

    test('should request an HLR', () {
      lookupService.requestHlr(credentials['msisdn']).then((hlr) {
        expect(hlr.id, isNotNull);
      });
    });

    test('should read an HLR', () {
      lookupService.readHlr(credentials['msisdn']).then((hlr) {
        expect(hlr.id, isNotNull);
      });
    });
  });
}
