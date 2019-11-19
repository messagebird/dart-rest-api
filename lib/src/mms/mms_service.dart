import 'package:http/http.dart' show Response;

/// Mms service interface
abstract class MmsService {
  /// Get a mms message
  Future<Response> readMmsMessage(String id);

  /// Sends a mms message
  Future<Response> createMmsMessage(Map<String, dynamic> parameters);

  /// Lists mms messages. Pagination is optional. If a limit is set, an
  /// offset is also required.
  Future<Response> listMmsMessages({int limit, int offset});

  /// Delete a mms message
  Future<Response> deleteMmsMessage(String id);
}
