import 'dart:io' show File;

import 'model/transcription.dart';

/// Transcriptions service interface.
abstract class TranscriptionsService {
  /// Creates a new transcription.
  Future<Transcription> create(
      String callId, String legId, String recordingId, String language);

  /// Downloads an existing transcription.
  Future<File> download(
      String callId, String legId, String recordingId, String transcriptionId);

  /// List transcriptions.
  Future<List<Transcription>> list(
      String callId, String legId, String recordingId);

  /// View an existing transcription.
  Future<Transcription> read(
      String callId, String legId, String recordingId, String transcriptionId);
}
