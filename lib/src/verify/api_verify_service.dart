import '../general/model/base_service.dart';

import 'model/verify.dart';
import 'model/verify_response.dart';
import 'verify_service.dart';

/// API implementation of verify service.
class ApiVerifyService extends BaseService implements VerifyService {
  /// Constructor.
  ApiVerifyService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<VerifyResponse> create(Verify verify) =>
      post('/verify', body: verify.toMap()).then((response) => Future.value(
          response?.body == null
              ? null
              : VerifyResponse.fromJson(response.body)));

  @override
  Future<VerifyResponse> read(String id) =>
      get('/verify/$id').then((response) => Future.value(
          response == null ? null : VerifyResponse.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete('/verify/$id');

  @override
  Future<VerifyResponse> verify(String id, String token) =>
      get('/verify/$id', body: {'token': token}).then((response) =>
          Future.value(response?.body == null
              ? null
              : VerifyResponse.fromJson(response.body)));
}
