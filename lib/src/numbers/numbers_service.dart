import 'model/numbers.dart';
import 'model/phone_number.dart';
import 'model/recently_purchased_phone_number.dart';

/// Numbers service interface
abstract class NumbersService {
  /// Retrieve a list of all your purchased phone numbers, filterable by a variety
  /// of criteria including phone number type, feature, tags or region.
  Future<Numbers> list(
      {int limit,
      int offset,
      List<String> features,
      List<String> tags,
      String number,
      String region,
      String locality,
      String type});

  /// Retrieve a specific phone number from your inventory of purchased numbers.
  Future<PhoneNumber> read(String number);

  /// Update certain attributes of your purchased phone numbers. Note: at the moment,
  /// we only support updating `tags` that can be used to group or label numbers.
  Future<PhoneNumber> update(String number, List<String> tags);

  /// Release this phone number from your account. You will no longer have access to
  /// this phone number and MessageBird will no longer receive calls or SMS/MMS messages
  /// on this number. You will stop being billed the monthly phone number fee and the
  /// phone number will eventually be recycled and potentially given to another customer,
  /// so use with care.
  Future<void> remove(String number);

  /// Purchase a phone number.
  Future<RecentlyPurchasedPhoneNumber> create(
      String number, String countryCode, int billingIntervalMonths);
}
