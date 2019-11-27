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
    final List<String> ids = [];
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
      ids.add(createdCall.id);
      expect(createdCall.source, equals(call.source));
    });

    test('should list calls', () async {
      expect(await callsService.list(), isNotEmpty);
    });

    test('should get a call', () async {
      expect((await callsService.read(ids[0])).id, isNotNull);
    });

    test('should get legs from a call', () async {
      expect(await callsService.listLegs(ids[0]), isList);
    });

    test('should read a leg from a call', () async {
      final List<Leg> legs = await callsService.listLegs(ids[0]);
      final Leg readLeg = await callsService.readLeg(ids[0], legs[0].id);
      expect(legs[0].id, equals(readLeg.id));
    });

    test('should update a call', () async {
      // Not testable.
    });

    test('should delete a call', () async {
      await callsService.remove(ids[0]);
      await callsService.read(ids[0]).catchError((error) {
        expect(error.toString(), contains('(code 13)')); // Not found
      });
    });
  });
}
