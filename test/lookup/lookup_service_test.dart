import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/hlr/model/hlr.dart';
import 'package:messagebird_dart/src/lookup/model/lookup.dart';
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

    test('should request a lookup', () async {
      final Lookup lookup = await lookupService.read(31617692626);
      expect(lookup.countryPrefix, equals(31));
      expect(lookup.type, equals(LookupType.mobile));
    });

    test('should request an HLR', () async {
      final Hlr hlr = await lookupService.requestHlr(31617692626);
      expect(hlr.id, isNotNull);
    });

    test('should read an HLR', () async {
      final Hlr hlr = await lookupService.readHlr(31617692626);
      expect(hlr.id, isNotNull);
    });
  });
}
