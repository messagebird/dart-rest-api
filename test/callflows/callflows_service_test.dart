import 'dart:convert';
import 'dart:io';

import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/callflows/model/callflow.dart';
import 'package:messagebird_dart/src/callflows/model/step.dart';
import 'package:test/test.dart';

void main() {
  group('CallflowService', () {
    Map credentials;
    CallflowsService callflowsService;
    Callflow callflow;
    String id;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      callflowsService = ApiCallflowsService(credentials['live']);
      callflow = const Callflow(title: 'Say message', record: true, steps: [
        Step(action: StepAction.say, options: {
          StepOption.payload: 'This is a journey into sound. Good bye!',
          StepOption.voice: 'male',
          StepOption.language: 'en-US'
        })
      ]);
    });

    test('should list callflows', () async {
      expect(await callflowsService.list(), isNotEmpty);
    });

    test('should create a callflow', () async {
      final Callflow createdCallflow = await callflowsService.create(callflow);
      id = createdCallflow.id;
      expect(createdCallflow.title, equals(callflow.title));
      expect(createdCallflow.record, equals(callflow.record));
      expect(createdCallflow.steps[0].action, equals(callflow.steps[0].action));
    });

    test('should get a callflow', () async {
      expect(await callflowsService.read(id), isNotNull);
    });

    test('should update a callflow', () async {
      await callflowsService.update(Callflow(id: id, title: 'Test'));
      expect((await callflowsService.read(id)).title, 'Test');
    });

    test('should delete a callflow', () async {
      await callflowsService.remove(id);
      expect(await callflowsService.read(id), isNull);
    });
  });
}
