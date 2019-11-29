import 'dart:typed_data';

import 'model/transcription.dart';

/// Transcriptions service interface.
abstract class TranscriptionsService {
  /// Creates a new transcription.
  Future<Transcription> create(
      String callId, String legId, String recordingId, String language);

  /// Downloads an existing transcription. Returns an [Uint8List] to write into
  /// a [dart:io/File] using method `writeAsBytes`.
  Future<Uint8List> download(
      String callId, String legId, String recordingId, String transcriptionId);

  /// View an existing transcription.
  Future<Transcription> read(
      String callId, String legId, String recordingId, String transcriptionId);
}
