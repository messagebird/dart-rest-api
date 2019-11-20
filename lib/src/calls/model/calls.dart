import 'package:messagebird_dart/src/calls/model/call.dart';

/// Class encapsulating a list of callflows.
class Calls {
  /// Listing of all [calls].
  final List<Call> calls;

  /// Constructor.
  Calls({this.calls});

  /// Construct a step object from a [json] object.
  factory Calls.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Calls(calls: Call.fromJsonList(json['data']));
  }
}
