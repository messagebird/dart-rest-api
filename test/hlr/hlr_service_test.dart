import 'dart:convert';
import 'dart:io';

import 'package:messagebird/hlr.dart';
import 'package:test/test.dart';

void main() {
  group('HlrService', () {
    Map credentials;
    String id;
    HlrService hlrService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      hlrService = ApiHlrService(credentials['live']
          .replaceAll('31612345678', credentials['msisdn'].toString()));
    });

    test('should create an HLR', () {
      hlrService.create(credentials['msisdn']).then((hlr) {
        expect(hlr.id, isNotNull);
        expect(hlr.status, isIn([HlrStatus.sent, HlrStatus.active]));
        id = hlr.id;
      });
    });

    test('should list HLRs', () {
      hlrService.list().then((list) {
        expect(list, isNotEmpty);
      });
    });

    test('should remove an HLR', () {
      hlrService.remove(id);
      hlrService.read(id).then((hlr) {
        expect(hlr, isNull);
      });
    });
  });
}
