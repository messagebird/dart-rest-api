import 'model/hlr.dart';

/// Hlr service interface.
abstract class HlrService {
  /// Send HLR network query to a number. Reference  is optional.
  Future<Hlr> create(int msisdn, {String reference});

  /// Get HLR report.
  Future<Hlr> read(String id);

  /// Delete a query/report.
  Future<void> remove(String id);

  /// List current HLR reports
  Future<List<Hlr>> list();
}
