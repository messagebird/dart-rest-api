import '../general/model/base_service.dart';
import 'numbers_service.dart';
import 'model/numbers.dart';
import 'model/phone_number.dart';
import 'model/recently_purchased_phone_number.dart';

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

  @override
  Future<PhoneNumber> read(String number) => get('/phone-numbers/${number}',
          hostname: BaseService.numbersEndpoint)
      .then((response) => Future.value(
          response?.body == null ? null : PhoneNumber.fromJson(response.body)));

  @override
  Future<PhoneNumber> update(String number, List<String> tags) =>
      patch('/phone-numbers/${number}',
          hostname: BaseService.numbersEndpoint,
          body: {
            'tags': tags,
          }).then((response) => Future.value(
          response?.body == null ? null : PhoneNumber.fromJson(response.body)));

  @override
  Future<void> remove(String number) =>
      delete('phone-numbers/${number}', hostname: BaseService.numbersEndpoint);

  @override
  Future<RecentlyPurchasedPhoneNumber> create(
          String number, String countryCode, int billingIntervalMonths) =>
      post('/phone-numbers', hostname: BaseService.numbersEndpoint, body: {
        'number': number,
        'countryCode': countryCode,
        'billingIntervalMonths': billingIntervalMonths,
      }).then((response) => Future.value(response?.body == null
          ? null
          : RecentlyPurchasedPhoneNumber.fromJson(response.body)));
}
