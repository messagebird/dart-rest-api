import 'dart:convert';

/// Class encapsulating a [Fallback] object.
class Fallback {
  /// The ID that identifies the channel over which the message should be sent.
  String from;

  /// This is optional. You can set a time period before attempting to send the
  /// [Fallback]. After this time, if the original message isn't in a
  /// successfully delivered state, the fallback will be triggered. Formatted as
  /// a short-hand duration, for example: "30m" for 30 minutes, "3h" for 3
  /// hours. If the fallback time period isn't specified, 1 minute will be used
  /// as the default value.
  String after;

  /// Constructor.
  Fallback({
    this.from,
    this.after,
  });

  /// Construct a [Fallback] object from a json [String].
  factory Fallback.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return Fallback.fromMap(decoded == null ? json.decode(source) : decoded[0]);
  }

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
