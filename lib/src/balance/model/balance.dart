import 'dart:convert';

/// Class encapsulating a [Balance] object.
class Balance {
  /// The payment method. Possible values are `prepaid` and `postpaid`.
  final String payment;

  /// The payment type. Possible values are: `credits`, `euros`, `pounds`
  /// and `dollars`. For all other supported currencies, an [ISO-4217](https://www.wikipedia.org/wiki/ISO_4217) code
  /// is returned.
  final String type;

  /// The amount of balance of the payment type. When postpaid is your payment
  /// method, the amount will be 0.
  final double amount;

  /// Constructor.
  Balance({
    this.payment,
    this.type,
    this.amount,
  });

  /// Construct a [Balance] object from a json [String].
  factory Balance.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return Balance.fromMap(decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct a [Balance] object from a [Map].
  factory Balance.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Balance(
          payment: map['payment'],
          type: map['type'],
          amount: double.parse(map['amount'].toString()),
        );
}
