import 'dart:typed_data';

import 'model/recording.dart';

/// Recordings service interface
abstract class RecordingsService {
  /// Download an existing recording. Returns an [Uint8List] to write into
  /// a [dart:io/File] using method `writeAsBytes`.
  Future<Uint8List> download(String callId, String legId, String recordingId);

  /// List recordings.
  Future<List<Recording>> list(String callId, String legId,
      {int limit, int offset});

  /// This request retrieves a recording resource. The parameters are the unique
  /// ID of the recording, the leg and the call with which the recording is
  /// associated.
  Future<Recording> read(String callId, String legId, String recordingId);

  /// This request deletes a recording. The parameters are the unique ID of the
  /// recording, the leg and the call with which the recording is associated.
  Future<void> remove(String callId, String legId, String recordingId);
}
