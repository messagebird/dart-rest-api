import 'dart:convert';
import 'dart:io';

import 'package:messagebird/voice_calling.dart';
import 'package:test/test.dart';

void main() {
  group('RecordingsService', () {
    Map credentials;
    RecordingsService recordingsService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      recordingsService = ApiRecordingsService(credentials['live']);
    });

    test('should read a recording', () {
      recordingsService
          .read(
              'e7dcb02a-229b-4ee8-8a44-3b696c137f1c',
              '0099622a-54cd-4f50-ae6c-50517159dfe7',
              '9bb3518a-7729-41bf-944c-17ba8d0a5563')
          .then((recording) {
        expect(recording.status, equals(RecordingStatus.done));
        expect(recording.createdAt,
            equals(DateTime(2019, 11, 28, 21, 45, 12).toUtc()));
      });
    });

    test('should list recordings', () {
      recordingsService
          .list('e7dcb02a-229b-4ee8-8a44-3b696c137f1c',
              '0099622a-54cd-4f50-ae6c-50517159dfe7')
          .then((recordings) {
        expect(recordings, isNotEmpty);
        expect(recordings[0].createdAt,
            equals(DateTime(2019, 11, 28, 21, 45, 12).toUtc()));
      });
    });

    test('should delete a recording', () {
      // Will not be implemented in a unit test.
    });
  });
}
