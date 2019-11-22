import 'dart:convert';

import 'package:messagebird_dart/src/hlr/model/hlr.dart';

import '../base_service.dart';
import 'lookup_service.dart';
import 'model/lookup.dart';

/// API implementation of lookup service.
class ApiLookupService extends BaseService implements LookupService {
  /// Constructor.
  ApiLookupService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Lookup> read(int phoneNumber, {String countryCode}) async {
    final response = await get('/lookup/$phoneNumber',
        body: countryCode == null ? {} : {'countryCode': countryCode});
    return Future.value(Lookup.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<Hlr> requestHlr(int phoneNumber,
      {String reference, String countryCode}) async {
    final Map<String, String> body = {};
    if (reference != null) {
      body.addAll({'reference': reference});
    }
    if (countryCode != null) {
      body.addAll({'countryCode': countryCode});
    }
    final response = await post('/lookup/$phoneNumber/hlr', body: body);
    return Future.value(Hlr.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<Hlr> readHlr(int phoneNumber, {String countryCode}) async {
    final response = await get('/lookup/$phoneNumber/hlr',
        body: countryCode == null ? {} : {'countryCode': countryCode});
    return Future.value(Hlr.fromJson(json.decode(response.body)['data']));
  }
}
