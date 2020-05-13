import '../general/model/base_service.dart';
import 'numbers_service.dart';
import 'model/numbers.dart';

/// API implementation of [NumbersService]
class ApiNumbersService extends BaseService implements NumbersService {
  /// Constructor
  ApiNumbersService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  String getEndpoint() => BaseService.numbersEndpoint;

  @override
  Future<Numbers> list(
          {int limit,
          int offset,
          List<String> features,
          List<String> tags,
          String number,
          String region,
          String locality,
          String type}) =>
      get('/phone-numbers', hostname: BaseService.numbersEndpoint, body: {
        'limit': limit,
        'offset': offset,
        'features': features?.join(','),
        'tags': tags?.join(','),
        'number': number,
        'region': region,
        'locality': locality,
        'type': type,
      }).then((response) => Future.value(
          response?.body == null ? null : Numbers.fromJson(response.body)));
}
