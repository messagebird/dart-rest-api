import 'package:http/http.dart' show Response;

/// Lookup service interface.
/// ignore: one_member_abstracts
abstract class LookupService {
  /// Do a phonenumber lookup.
  Future<Response> read(String phoneNumber, String countryCode);
}
