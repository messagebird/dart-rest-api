import '../general/model/base_service.dart';
import '../hlr/model/hlr.dart';
import 'lookup_service.dart';
import 'model/lookup.dart';

/// API implementation of lookup service.
class ApiLookupService extends BaseService implements LookupService {
  /// Constructor.
  ApiLookupService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Lookup> read(int phoneNumber, {String countryCode}) =>
      get('/lookup/$phoneNumber',
              body: countryCode == null ? {} : {'countryCode': countryCode})
          .then((response) => Future.value(
              response == null ? null : Lookup.fromJson(response.body)));

  @override
  Future<Hlr> readHlr(int phoneNumber, {String countryCode}) => get(
          '/lookup/$phoneNumber/hlr',
          body: countryCode == null ? {} : {'countryCode': countryCode})
      .then((response) =>
          Future.value(response == null ? null : Hlr.fromJson(response.body)));

  @override
  Future<Hlr> requestHlr(int phoneNumber,
          {String reference, String countryCode}) =>
      post('/lookup/$phoneNumber/hlr',
              body: {'countryCode': countryCode, 'reference': reference})
          .then((response) => Future.value(Hlr.fromJson(response.body)));
}
