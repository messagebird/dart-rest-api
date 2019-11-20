import 'callflow.dart';

/// Class encapsulating a list of [Callflows].
class Callflows {
  /// Listing of all [Callflows].
  final List<Callflow> callflows;

  /// Constructor.
  Callflows({this.callflows});

  /// Construct a [Callflows] object from a [json] object.
  factory Callflows.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Callflows(callflows: Callflow.fromJsonList(json['data']));
}
