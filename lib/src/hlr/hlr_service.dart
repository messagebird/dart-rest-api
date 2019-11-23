import 'model/hlr.dart';

/// Hlr service interface.
abstract class HlrService {
  /// Send HLR network query to a number. Ref parameter is optional.
  Future<Hlr> create(int msisdn, {String ref});

  /// Get HLR report.
  Future<Hlr> read(String id);
}
