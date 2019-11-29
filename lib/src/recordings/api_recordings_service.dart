import 'dart:typed_data';

import 'package:messagebird_dart/src/general/model/base_service.dart';

import 'model/recording.dart';
import 'recordings_service.dart';

/// API implementation of recordings service.
class ApiRecordingsService extends BaseService implements RecordingsService {
  /// Constructor.
  ApiRecordingsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Uint8List> download(String callId, String legId, String recordingId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId.wav',
              hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(response?.bodyBytes));

  @override
  Future<List<Recording>> list(String callId, String legId,
          {int limit, int offset}) =>
      get('/calls/$callId/legs/$legId/recordings',
              hostname: BaseService.voiceEndpoint)
          .then((response) =>
              Future.value(Recording.fromJsonList(response.body)));

  @override
  Future<Recording> read(String callId, String legId, String recordingId) =>
      get('/calls/$callId/legs/$legId/recordings/$recordingId',
              hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(
              response == null ? null : Recording.fromJson(response.body)));

  @override
  Future<void> remove(String callId, String legId, String recordingId) =>
      delete('/calls/$callId/legs/$legId/recordings/$recordingId',
          hostname: BaseService.voiceEndpoint);
}
