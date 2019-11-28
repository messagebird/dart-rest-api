import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/mms/model/mms_message.dart';
import 'package:messagebird_dart/src/mms/model/recipients.dart';
import 'package:test/test.dart';

void main() {
  group('MmsService', () {
    Map credentials;
    String id;
    MmsService mmsService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      mmsService = ApiMmsService(credentials['test']);
    });

    test('should send a message', () async {
      final MmsMessage mmsMessage = await mmsService.create(MmsMessage(
          originator: 'Drillster',
          recipients: Recipients(
              totalCount: 1,
              items: [const RecipientItem(recipient: 31617692626)]),
          body: 'Hello world!'));
      expect(mmsMessage.createdDatetime.day, equals(DateTime.now().day));
      id = mmsMessage.id;
    });

    test('should read a message', () async {
      //final MmsMessage mmsMessage = await mmsService.read(id);
      //expect(mmsMessage.id, equals(id));
    });
  });
}
