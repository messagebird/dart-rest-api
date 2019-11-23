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
  Future<Hlr> create(int msisdn, {String ref}) async {
    final Map<String, dynamic> body = {};
    if (msisdn != null) {
      body.addAll({'msdisdn': msisdn});
    }
    if (ref != null) {
      body.addAll({'reference': ref});
    }
    final response = await post('/hlr', body: body);
    return Future.value(Hlr.fromJson(response.body));
  }

  @override
  Future<Hlr> read(String id) async {
    final response = await get('/hlr/$id');
    return Future.value(Hlr.fromJson(json.decode(response.body)['data']));
  }
}
