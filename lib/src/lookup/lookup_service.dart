import 'package:http/http.dart' show Response;

/// Lookup service interface
/// ignore: one_member_abstracts
abstract class LookupService {
  /// Do a phonenumber lookup
  Future<Response> lookup(String phoneNumber, String countryCode);
}
