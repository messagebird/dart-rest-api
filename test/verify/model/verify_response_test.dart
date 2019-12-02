import 'dart:io';
import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('VerifyResponse', () {
    VerifyResponse verifyResponse;

    setUp(() {
      verifyResponse = VerifyResponse.fromJson(
          File('test_resources/verify_response.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(verifyResponse.id, equals('4e213b01155d1e35a9d9571v00162985'));
      expect(
          verifyResponse.messages.href,
          equals(
              'https://rest.messagebird.com/messages/31bce2a1155d1f7c1db9df6b32167259'));
      expect(verifyResponse.createdDatetime,
          DateTime.parse('2016-05-03T14:26:57+00:00'));
    });
  });
}
