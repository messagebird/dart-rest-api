import 'callflow.dart';

/// Class encapsulating a list of callflows.
class Callflows {
  /// Listing of all [callflows].
  final List<Callflow> callflows;

  /// Constructor.
  Callflows({this.callflows});

  /// Construct a step object from a [json] object.
  factory Callflows.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Callflows(callflows: Callflow.fromJsonList(json['data']));
  }
}
