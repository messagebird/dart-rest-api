import 'package:http/http.dart' show Response;
import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/base_service.dart';

/// API implementation of verify service.
class ApiVerifyService extends BaseService implements VerifyService {
  /// Constructor.
  ApiVerifyService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(int recipient, Map<String, dynamic> parameters) {
    parameters['recipient'] = recipient;
    return post('/verify', body: parameters);
  }

  @override
  Future<Response> read(String id) => get('/verify/$id');

  @override
  Future<Response> remove(String id) => delete('/verify/$id');

  @override
  Future<Response> verify(String id, String token) =>
      get('/verify/$id', body: {'token': token});
}
