import '../hlr/model/hlr.dart';
import 'model/lookup.dart';

/// Lookup service interface.
abstract class LookupService {
  /// Perform a new lookup for the specified number. MessageBird returns a
  /// Lookup object with each request.
  Future<Lookup> read(int phoneNumber, {String countryCode});

  /// Create a new HLR object. MessageBird returns the created HLR object with
  /// each request.
  Future<Hlr> requestHlr(int phoneNumber,
      {String reference, String countryCode});

  /// Retrieves the information of an existing HLR.
  Future<Hlr> readHlr(int phoneNumber, {String countryCode});
}
