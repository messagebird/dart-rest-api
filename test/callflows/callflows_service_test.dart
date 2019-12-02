import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
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

    test('should list callflows', () {
      callflowsService.list().then((list) {
        expect(list, isNotEmpty);
      });
    });

    test('should create a callflow', () {
      callflowsService.create(callflow).then((createdCallflow) {
        id = createdCallflow.id;
        expect(createdCallflow.title, equals(callflow.title));
        expect(createdCallflow.record, equals(callflow.record));
        expect(
            createdCallflow.steps[0].action, equals(callflow.steps[0].action));
      });
    });

    test('should get a callflow', () {
      callflowsService.read(id).then((readCallflow) {
        expect(readCallflow.title, equals(callflow.title));
        expect(readCallflow.record, equals(callflow.record));
        expect(readCallflow.steps[0].action, equals(callflow.steps[0].action));
      });
    });

    test('should update a callflow', () {
      callflowsService
          .update(Callflow(id: id, title: 'Test'))
          .then((updatedCallflow) {
        callflowsService.read(id).then((readCallflow) {
          expect(readCallflow.title, 'Test');
        });
      });
    });

    test('should delete a callflow', () {
      callflowsService.remove(id);
      callflowsService.read(id).then((callflow) {
        expect(callflow, isNull);
      });
    });
  });
}
