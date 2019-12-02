import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('CallsService', () {
    Map credentials;
    String id;
    CallsService callsService;
    Call call;
    Callflow callflow;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      callsService = ApiCallsService(credentials['live']);
      call = Call.fromJson(File('test_resources/call.json')
          .readAsStringSync()
          .replaceAll('31612345678', credentials['msisdn'].toString()));
      callflow = Callflow.fromJson(
          File('test_resources/callflow.json').readAsStringSync());
    });

    test('should create a call', () async {
      await callsService.create(call, callflow).then((createdCall) {
        id = createdCall.id;
        expect(createdCall.source, equals(call.source));
      });
    });

    test('should list calls', () {
      callsService.list().then((list) {
        expect(list, isNotEmpty);
      });
    });

    test('should get a call', () {
      callsService.read(id).then((readCall) {
        expect(readCall.id, isNotNull);
        expect(readCall.source, equals(call.source));
      });
    });

    test('should get legs from a call', () {
      callsService.listLegs(id).then((list) {
        expect(list, isList);
      });
    });

    test('should read a leg from a call', () {
      callsService.listLegs(id).then((legs) {
        callsService.readLeg(id, legs[0].id).then((readLeg) {
          expect(legs[0].id, equals(readLeg.id));
        });
      });
    });

    test('should update a call', () {
      // Not testable.
    });

    test('should delete a call', () async {
      await callsService.remove(id);
      sleep(const Duration(seconds: 1)); // Allow a second for the call to end
      await callsService.read(id).then((readCall) {
        expect(readCall.status, equals(CallStatus.ended));
      });
    });
  });
}
