import '../general/model/base_service.dart';
import 'hlr_service.dart';
import 'model/hlr.dart';

/// API implementation of hlr service.
class ApiHlrService extends BaseService implements HlrService {
  /// Constructor.
  ApiHlrService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Hlr> create(int msisdn, {String reference}) =>
      post('/hlr', body: {'msisdn': msisdn, 'reference': reference})
          .then((response) => Future.value(Hlr.fromJson(response.body)));

  @override
  Future<Hlr> read(String id) => get('/hlr/$id').then((response) =>
      Future.value(response == null ? null : Hlr.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete('/hlr/$id');

  @override
  Future<List<Hlr>> list() => get('/hlr')
      .then((response) => Future.value(Hlr.fromJsonList(response.body)));
}
