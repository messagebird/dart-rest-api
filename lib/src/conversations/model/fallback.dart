import 'dart:convert';

/// Class encapsulating a [Fallback] object.
///
/// The Fallback parameter allows you to configure a message to be sent over a
/// secondary channel if the original message failed or could not be sent within
/// a defined time window.
///
/// For example, when sending a WhatsApp message to a customer, you can
/// configure a fallback so that if the customer is not a WhatsApp user or
/// doesn't have a mobile data connection, the message is resent over SMS.
/// You can define the time at which the fallback message should be sent if it
/// wasn't successful over the primary channel; if you don't set a time, the
/// fallback will automatically trigger after 1 minute.
class Fallback {
  /// The ID that identifies the channel over which the message should be sent.
  final String from;

  /// This is optional. You can set a time period before attempting to send the
  /// [Fallback]. After this time, if the original message isn't in a
  /// successfully delivered state, the fallback will be triggered. Formatted as
  /// a short-hand duration, for example: "30m" for 30 minutes, "3h" for 3
  /// hours. If the fallback time period isn't specified, 1 minute will be used
  /// as the default value.
  final String after;

  /// Constructor.
  const Fallback({
    this.from,
    this.after = '1m',
  });

  /// Construct a [Fallback] object from a json [String].
  factory Fallback.fromJson(String source) =>
      Fallback.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Fallback] object from a [Map].
  factory Fallback.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Fallback(
          from: map['from'],
          after: map['after'],
        );

  /// Get a json [String] representing the [Fallback].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'from': from,
        'after': after,
      };
}
