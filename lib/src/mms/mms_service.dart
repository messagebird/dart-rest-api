import 'model/mms_message.dart';

/// Mms service interface.
abstract class MmsService {
  /// Sends a mms message.
  Future<MmsMessage> create(MmsMessage mmsMessage);

  /// Lists mms messages. Pagination is optional. If a limit is set, an
  /// offset is also required.
  Future<List<MmsMessage>> list({int limit, int offset});

  /// Get a mms message.
  Future<MmsMessage> read(String id);

  /// Removes a mms message.
  Future<void> remove(String id);
}
