import 'package:http/http.dart' show Response;

/// Hlr service interface.
abstract class HlrService {
  /// Send HLR network query to a number. Ref parameter is optional.
  Future<Response> create(int msdisdn, {String ref});

  /// Get HLR report.
  Future<Response> read(String id);
}
