import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/hlr/model/hlr.dart';
import 'package:test/test.dart';

void main() {
  group('HlrService', () {
    Map credentials;
    String id;
    HlrService hlrService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      hlrService = ApiHlrService(credentials['live']);
    });

    test('should create an HLR', () async {
      final Hlr hlr = await hlrService.create(31617692626);
      expect(hlr.id, isNotNull);
      expect(hlr.status, isIn([HlrStatus.sent, HlrStatus.active]));
      id = hlr.id;
    });

    test('should list HLRs', () async {
      final List<Hlr> hlrs = await hlrService.list();
      expect(hlrs, isNotEmpty);
    });

    test('should remove an HLR', () async {
      await hlrService.remove(id);
      expect(await hlrService.read(id), isNull);
    });
  });
}
