import 'dart:io' show File;

import 'model/recording.dart';

/// Recordings service interface
abstract class RecordingsService {
  /// Download an existing recording.
  Future<File> download(String callId, String legId, String recordingId);

  /// List recordings.
  Future<List<Recording>> list(String callId, String legId,
      {int limit, int offset});

  /// View an existing recording.
  Future<Recording> read(String callId, String legId, String recordingId);
}
