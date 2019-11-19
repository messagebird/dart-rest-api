import 'package:http/http.dart' show Response;

/// Mms service interface.
abstract class MmsService {
  /// Sends a mms message.
  Future<Response> create(Map<String, dynamic> parameters);

  /// Lists mms messages. Pagination is optional. If a limit is set, an
  /// offset is also required.
  Future<Response> list({int limit, int offset});

  /// Get a mms message.
  Future<Response> read(String id);

  /// Removes a mms message.
  Future<Response> remove(String id);
}
