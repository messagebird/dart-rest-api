import 'dart:io';

import 'package:messagebird/mms.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('MmsService', () {
    String id;
    MmsService mmsService;

    setUp(() {
      mmsService = ApiMmsService(credentials.API_LIVE_KEY);
    });

    test('should send a message', () {
      mmsService
          .create(MmsMessage(
              originator: 'Drillster',
              recipients: Recipients(
                  totalCount: 1,
                  items: [RecipientItem(recipient: credentials.MSISDN)]),
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
  }, skip: !credentials.hasMSISDN || !credentials.arePresent);
}
