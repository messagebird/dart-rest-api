import 'dart:convert';
import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  group('TranscriptionService', () {
    Map credentials;
    TranscriptionsService transcriptionsService;

    setUp(() {
      credentials =
          json.decode(File('test_resources/keys.json').readAsStringSync());
      transcriptionsService = ApiTranscriptionsService(credentials['live']);
    });

    test('should create a transcription', () {
      // Not implemented as a unit test.
    });

    test('should read a transcription', () {
      transcriptionsService
          .read(
              'e7dcb02a-229b-4ee8-8a44-3b696c137f1c',
              '0099622a-54cd-4f50-ae6c-50517159dfe7',
              '9bb3518a-7729-41bf-944c-17ba8d0a5563',
              '49f8e2dd-58ce-4476-a6a1-9846d78b418a')
          .then((transcription) {
        expect(transcription.recordingId,
            equals('9bb3518a-7729-41bf-944c-17ba8d0a5563'));
        expect(transcription.createdAt,
            equals(DateTime(2019, 11, 29, 13, 29, 56).toUtc()));
      });
    });

    test('should download a transcription', () {
      transcriptionsService
          .download(
              'e7dcb02a-229b-4ee8-8a44-3b696c137f1c',
              '0099622a-54cd-4f50-ae6c-50517159dfe7',
              '9bb3518a-7729-41bf-944c-17ba8d0a5563',
              '49f8e2dd-58ce-4476-a6a1-9846d78b418a')
          .then((bytes) {
        expect(bytes, isNotNull);
      });
    });
  });
}
