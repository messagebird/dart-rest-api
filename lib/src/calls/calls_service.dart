import '../callflows/model/callflow.dart';

import 'model/call.dart';
import 'model/leg.dart';

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

  /// List the [Leg] objects from a [Call].
  Future<List<Leg>> listLegs(String callId);

  /// Read a [Leg] from a [Call].
  Future<Leg> readLeg(String callId, String legId);
}
