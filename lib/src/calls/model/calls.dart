import 'call.dart';

/// Class encapsulating a list of [Calls].
class Calls {
  /// Listing of all [Calls].
  final List<Call> calls;

  /// Constructor.
  Calls({this.calls});

  /// Construct a [Calls] object from a [json] object.
  factory Calls.fromJson(Map<String, dynamic> json) =>
      json == null ? null : Calls(calls: Call.fromJsonList(json['data']));
}
