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
  Future<Hlr> create(int msdisdn, {String ref}) async {
    final response =
        await post('/hlr', body: {'msisdn': msdisdn, 'reference': ref});
    return Future.value(Hlr.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<Hlr> read(String id) async {
    final response = await get('/hlr/$id');
    return Future.value(Hlr.fromJson(json.decode(response.body)['data']));
  }
}
