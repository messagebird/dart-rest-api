import 'package:http/http.dart' show Response;

/// Recordings service interface
abstract class RecordingsService {
  /// Download an existing recording.
  Future<Response> download(String callId, String legId, String recordingId);

  /// List recordings.
  Future<Response> list(String callId, String legId, {int limit, int offset});

  /// View an existing recording.
  Future<Response> read(String callId, String legId, String recordingId);
}
