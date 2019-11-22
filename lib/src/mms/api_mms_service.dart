import 'package:messagebird_dart/src/mms/model/mms_message.dart';

import '../base_service.dart';
import 'mms_service.dart';

/// API implementation of mms service.
class ApiMmsService extends BaseService implements MmsService {
  /// Constructor.
  ApiMmsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<MmsMessage> create(MmsMessage message) async {
    final response = await post('/mms', body: message.toMap());
    return Future.value(MmsMessage.fromJson(response.body));
  }

  @override
  Future<List<MmsMessage>> list({int limit, int offset}) async {
    final response =
        await get('/mms', body: {'limit': limit, 'offset': offset});
    return Future.value(MmsMessage.fromList(response.body));
  }

  @override
  Future<MmsMessage> read(String id) async {
    final response = await get('/mms/$id');
    return Future.value(MmsMessage.fromJson(response.body));
  }

  @override
  Future<void> remove(String id) => delete('/mms/$id');
}
