import 'package:messagebird_dart/src/callflows/model/callflow.dart';

import 'model/call.dart';

/// Calls service interface.
abstract class CallsService {
  /// Create a [Call].
  Future<Call> create(Call call, Callflow callflow);

  /// List existing [Call] objects.
  Future<List<Call>> list();

  /// Read a [Call].
  Future<Call> read(String id);

  /// Remove a [Call].
  Future<void> remove(String id);
}
