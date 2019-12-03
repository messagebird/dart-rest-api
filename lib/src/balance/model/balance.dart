import 'dart:convert';

import '../../util.dart';

/// This object represents your balance at MessageBird.com.
class Balance {
  /// The payment method. See [Payment] for allowed values.
  final Payment payment;

  /// The payment type. Possible values are: `credits`, `euros`, `pounds`
  /// and `dollars`. For all other supported currencies, an [ISO-4217](https://www.wikipedia.org/wiki/ISO_4217)
  /// code is returned.
  final String type;

  /// The amount of balance of the payment type. When postpaid is your payment
  /// method, the amount will be 0.
  final double amount;

  /// Constructor.
  const Balance({
    this.payment,
    this.type,
    this.amount,
  });

  /// Construct a [Balance] object from a json [String].
  factory Balance.fromJson(String source) =>
      Balance.fromMap(json.decode(source));

  /// Construct a [Balance] object from a [Map].
  factory Balance.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Balance(
          payment: Payment.values.firstWhere(
              (payment) => payment.toString() == 'Payment.${map['payment']}',
              orElse: () => null),
          type: map['type'],
          amount: parseDouble(map['amount'].toString()),
        );
}

/// Enumeration of possible payment types.
enum Payment {
  /// The [Balance] is paid in advance.
  prepaid,

  /// The [Balance] is paid afterwards.
  postpaid
}
