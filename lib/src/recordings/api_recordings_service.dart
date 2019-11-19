import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'recordings_service.dart';

/// API implementation of recordings service.
class ApiRecordingsService extends BaseService implements RecordingsService {
  /// Constructor.
  ApiRecordingsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> download(String callId, String legId, String recordingId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId.wav',
          hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> list(String callId, String legId, {int limit, int offset}) =>
      get('/calls/$callId/legs/$legId/recordings',
          hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> read(String callId, String legId, String recordingId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId',
          hostname: BaseService.voiceEndpoint);
}
