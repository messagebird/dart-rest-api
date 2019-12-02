import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('MmsService', () {
    Map credentials;
    String id;
    MmsService mmsService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      mmsService = ApiMmsService(credentials['live']);
    });

    test('should send a message', () {
      mmsService
          .create(MmsMessage(
              originator: 'Drillster',
              recipients: Recipients(
                  totalCount: 1,
                  items: [RecipientItem(recipient: credentials['msisdn'])]),
              body: 'Hello world!'))
          .then((mmsMessage) {
        expect(mmsMessage.createdDatetime.day, equals(DateTime.now().day));
        id = mmsMessage.id;
      });
    });

    test('should read a message', () {
      mmsService.read(id).then((mmsMessage) {
        expect(mmsMessage.id, equals(id));
      });
    });
  });
}
