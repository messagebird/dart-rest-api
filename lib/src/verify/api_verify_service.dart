import 'package:messagebird_dart/src/base_service.dart';

import 'model/verify.dart';
import 'verify_service.dart';

/// API implementation of verify service.
class ApiVerifyService extends BaseService implements VerifyService {
  /// Constructor.
  ApiVerifyService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Verify> create(Verify verify) => post('/verify', body: verify.toMap())
      .then((response) => Future.value(Verify.fromJson(response.body)));

  @override
  Future<Verify> read(String id) => get('/verify/$id')
      .then((response) => Future.value(Verify.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete('/verify/$id');

  @override
  Future<Verify> verify(String id, String token) =>
      get('/verify/$id', body: {'token': token})
          .then((response) => Future.value(Verify.fromJson(response.body)));
}
