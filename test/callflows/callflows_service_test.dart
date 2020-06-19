import 'dart:io';

import 'package:messagebird/voice_calling.dart';
import 'package:test/test.dart';

import '../credentials.dart';

void main() {
  final Credentials credentials = Credentials.from(Platform.environment);

  group('CallflowService', () {
    CallflowsService callflowsService;
    Callflow callflow;
    String id;

    setUp(() {
      callflowsService = ApiCallflowsService(credentials.API_LIVE_KEY);
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
  }, skip: !credentials.arePresent);
}
