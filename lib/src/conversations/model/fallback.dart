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
  Fallback({this.from, this.after});

  factory Fallback.fromJson(Map<String, dynamic> json) =>
      json == null ? null : Fallback(from: json['from'], after: json['after']);
}
