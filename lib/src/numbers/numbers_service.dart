import 'model/numbers.dart';

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
}
