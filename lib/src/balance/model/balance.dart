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
  Balance({this.payment, this.type, this.amount});

  /// Construct a balance object from a json object.
  factory Balance.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Balance(
          payment: json['payment'].toString(),
          type: json['type'].toString(),
          amount: double.parse(json['amount'].toString()));
}
