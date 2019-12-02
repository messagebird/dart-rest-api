import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('Callflows', () {
    Callflow callflow;

    setUp(() {
      callflow = Callflow.fromJson(
          File('test_resources/callflow.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(callflow.title, equals('Say message'));
      expect(callflow.record, equals(true));
      expect(callflow.steps[0].action, equals(StepAction.say));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = callflow.toMap();

      expect(serialized['id'], equals(callflow.id));
      expect(serialized['title'], equals(callflow.title));
      expect(serialized['record'], equals(callflow.record));
      expect(serialized['steps'][0]['id'], equals(callflow.steps[0].id));
    });
  });
}
