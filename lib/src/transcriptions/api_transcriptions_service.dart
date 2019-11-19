import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'transcriptions_service.dart';

/// API implementation of transcription service.
class ApiTranscriptionsService extends BaseService
    implements TranscriptionsService {
  /// Constructor.
  ApiTranscriptionsService(String accessKey,
      {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(
          String callId, String legId, String recordingId, String language) =>
      post('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions',
          hostname: BaseService.voiceEndpoint, body: {'language': language});

  @override
  Future<Response> download(String callId, String legId, String recordingId,
          String transcriptionId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions/$transcriptionId.txt',
          hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> list(String callId, String legId, String recordingId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions',
          hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> read(String callId, String legId, String recordingId,
          String transcriptionId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId/transcriptions/$transcriptionId',
          hostname: BaseService.voiceEndpoint);
}
