import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'mms_service.dart';
import 'model/mms_message.dart';

/// API implementation of mms service.
class ApiMmsService extends BaseService implements MmsService {
  /// Constructor.
  ApiMmsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<MmsMessage> create(MmsMessage message) =>
      post('/mms', body: message.toMap(send: true))
          .then((response) => Future.value(MmsMessage.fromJson(response.body)));

  @override
  Future<List<MmsMessage>> list({int limit, int offset}) =>
      get('/mms', body: {'limit': limit, 'offset': offset}).then(
          (response) => Future.value(MmsMessage.fromJsonList(response.body)));

  @override
  Future<MmsMessage> read(String id) =>
      get('/mms/$id').then((response) => Future.value(
          response == null ? null : MmsMessage.fromJson(response.body)));

  @override
  Future<void> remove(String id) => delete('/mms/$id');
}
