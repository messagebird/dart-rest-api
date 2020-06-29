import 'dart:io';

import 'package:messagebird/exceptions.dart';
import 'package:messagebird/voice_calling.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('CallsService', () {
    String id;
    CallsService callsService;
    Call call;
    Callflow callflow;

    setUp(() {
      callsService = ApiCallsService(credentials.API_LIVE_KEY);
      call = Call.fromJson(File('test_resources/call.json')
          .readAsStringSync()
          .replaceAll('31612345678', credentials.MSISDN.toString()));
      callflow = Callflow.fromJson(
          File('test_resources/callflow.json').readAsStringSync());
    });

    test('should create a call', () async {
      await callsService.create(call, callflow).then((createdCall) {
        id = createdCall.id;
        expect(createdCall.source, equals(call.source));
      });
    });

    test('should list calls', () async {
      await callsService.list().then((list) {
        expect(list, isNotEmpty);
      });
    });

    test('should get a call', () async {
      await callsService.read(id).then((readCall) {
        expect(readCall.id, isNotNull);
        expect(readCall.source, equals(call.source));
      });
    });

    test('should get legs from a call', () async {
      await callsService.listLegs(id).then((list) {
        expect(list, isList);
      });
    });

    test('should read a leg from a call', () async {
      await callsService.listLegs(id).then((legs) async {
        await callsService.readLeg(id, legs[0].id).then((readLeg) {
          expect(legs[0].id, equals(readLeg.id));
        });
      });
    });

    test('should update a call', () {
      // Not testable.
    });

    test('should delete a call', () async {
      await callsService.remove(id).catchError((error) {
        if (error is ApiError) {
          fail('The service replied with code ${error.code}:'
              '${error.description}');
        } else {
          fail('The service failed with an ${error.runtimeType}');
        }
      });
    });
  }, skip: !credentials.hasMSISDN || !credentials.arePresent);
}
