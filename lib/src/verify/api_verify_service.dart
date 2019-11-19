import 'package:http/http.dart' show Response;
import 'package:messagebird_dart/messagebird_dart.dart';
import 'package:messagebird_dart/src/base_service.dart';

/// API implementation of verify service
class ApiVerifyService extends BaseService implements VerifyService {
  /// Constructor
  ApiVerifyService(String accessKey) : super(accessKey);

  @override
  Future<Response> createCode(int recipient, Map<String, dynamic> parameters) {
    parameters['recipient'] = recipient;
    return post('/verify', body: parameters);
  }

  @override
  Future<Response> deleteCode(String id) => delete('/verify/$id');

  @override
  Future<Response> readCode(String id) => get('/verify/$id');

  @override
  Future<Response> verifyCode(String id, String token) =>
      get('/verify/$id', body: {'token': token});
}
