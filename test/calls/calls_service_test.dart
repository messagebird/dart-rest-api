import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/callflows/model/callflow.dart';
import 'package:messagebird_dart/src/calls/model/call.dart';
import 'package:messagebird_dart/src/calls/model/leg.dart';
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
      call = Call.fromJson(File('test_resources/call.json').readAsStringSync());
      callflow = Callflow.fromJson(
          File('test_resources/callflow.json').readAsStringSync());
    });

    test('should create a call', () async {
      final Call createdCall = await callsService.create(call, callflow);
      id = createdCall.id;
      expect(createdCall.source, equals(call.source));
    });

    test('should list calls', () async {
      expect(await callsService.list(), isNotEmpty);
    });

    test('should get a call', () async {
      expect((await callsService.read(id)).id, isNotNull);
    });

    test('should get legs from a call', () async {
      expect(await callsService.listLegs(id), isList);
    });

    test('should read a leg from a call', () async {
      final List<Leg> legs = await callsService.listLegs(id);
      final Leg readLeg = await callsService.readLeg(id, legs[0].id);
      expect(legs[0].id, equals(readLeg.id));
    });

    test('should update a call', () async {
      // Not testable.
    });

    test('should delete a call', () async {
      await callsService.remove(id);

      Call call;
      final Timer timer = Timer(const Duration(seconds: 5), () => null);
      while (call == null ||
          call.status == CallStatus.starting ||
          timer.isActive) {
        call = await callsService.read(id);
      }

      expect(call.status, equals(CallStatus.ended));
    });
  });
}
