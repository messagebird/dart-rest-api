import 'dart:convert';

import '../base_service.dart';
import 'hlr_service.dart';
import 'model/hlr.dart';

/// API implementation of hlr service.
class ApiHlrService extends BaseService implements HlrService {
  /// Constructor.
  ApiHlrService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Hlr> create(int msisdn, {String ref}) =>
      post('/hlr', body: {'msdisdn': msisdn.toString(), 'reference': ref})
          .then((response) => Future.value(Hlr.fromJson(response.body)));

  @override
  Future<Hlr> read(String id) => get('/hlr/$id').then((response) =>
      Future.value(Hlr.fromJson(json.decode(response.body)['data'])));
}
