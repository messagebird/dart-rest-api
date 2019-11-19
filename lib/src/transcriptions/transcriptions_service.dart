import 'package:http/http.dart' show Response;

/// Transcriptions service interface.
abstract class TranscriptionsService {
  /// Creates a new transcription.
  Future<Response> create(
      String callId, String legId, String recordingId, String language);

  /// Downloads an existing transcription.
  Future<Response> download(
      String callId, String legId, String recordingId, String transcriptionId);

  /// List transcriptions.
  Future<Response> list(String callId, String legId, String recordingId);

  /// View an existing transcription.
  Future<Response> read(
      String callId, String legId, String recordingId, String transcriptionId);
}
