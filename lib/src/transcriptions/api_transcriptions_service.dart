import 'dart:io' show File;

import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'model/transcription.dart';
import 'transcriptions_service.dart';

/// API implementation of transcription service.
class ApiTranscriptionsService extends BaseService
    implements TranscriptionsService {
  /// Constructor.
  ApiTranscriptionsService(String accessKey,
      {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Transcription> create(
          String callId, String legId, String recordingId, String language) =>
      post('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions',
              hostname: BaseService.voiceEndpoint, body: {'language': language})
          .then((response) =>
              Future.value(Transcription.fromJson(response.body)));

  @override
  Future<File> download(String callId, String legId, String recordingId,
          String transcriptionId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions/$transcriptionId.txt',
              hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(
              response == null ? null : File.fromRawPath(response.bodyBytes)));

  @override
  Future<List<Transcription>> list(
          String callId, String legId, String recordingId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions',
              hostname: BaseService.voiceEndpoint)
          .then((response) =>
              Future.value(Transcription.fromJsonList(response.body)));

  @override
  Future<Transcription> read(String callId, String legId, String recordingId,
          String transcriptionId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions/$transcriptionId',
              hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(
              response == null ? null : Transcription.fromJson(response.body)));
}
