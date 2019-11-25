import 'dart:convert';

import 'package:messagebird_dart/src/hlr/model/hlr.dart';

import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'lookup_service.dart';
import 'model/lookup.dart';

/// API implementation of lookup service.
class ApiLookupService extends BaseService implements LookupService {
  /// Constructor.
  ApiLookupService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Lookup> read(int phoneNumber, {String countryCode}) => get(
          '/lookup/$phoneNumber',
          body: countryCode == null ? {} : {'countryCode': countryCode})
      .then((response) =>
          Future.value(Lookup.fromJson(json.decode(response.body)['data'])));

  @override
  Future<Hlr> requestHlr(int phoneNumber,
          {String reference, String countryCode}) =>
      post('/lookup/$phoneNumber/hlr',
              body: {'countryCode': countryCode, 'reference': reference})
          .then((response) =>
              Future.value(Hlr.fromJson(json.decode(response.body)['data'])));

  @override
  Future<Hlr> readHlr(int phoneNumber, {String countryCode}) =>
      get('/lookup/$phoneNumber/hlr',
              body: countryCode == null ? {} : {'countryCode': countryCode})
          .then((response) =>
              Future.value(Hlr.fromJson(json.decode(response.body)['data'])));
}
