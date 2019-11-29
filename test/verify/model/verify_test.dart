import 'dart:io';
import 'package:messagebird_dart/src/verify/model/verify_response.dart';
import 'package:test/test.dart';

void main() {
  group('Verify', () {
    VerifyResponse verify;

    setUp(() {
      verify = VerifyResponse.fromJson(
          File('test_resources/verify.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(verify.id, equals('4e213b01155d1e35a9d9571v00162985'));
      expect(
          verify.messages.href,
          equals(
              'https://rest.messagebird.com/messages/31bce2a1155d1f7c1db9df6b32167259'));
      expect(
          verify.createdDatetime, DateTime.parse('2016-05-03T14:26:57+00:00'));
    });
  });
}
