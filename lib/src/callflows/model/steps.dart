import 'step.dart';

/// Class encapsulating a list of [Steps].
class Steps {
  /// Listing of all [steps].
  final List<Step> steps;

  /// Constructor.
  Steps({this.steps});

  /// Construct a [Steps] object from a [json] object.
  factory Steps.fromJson(Map<String, dynamic> json) =>
      json == null ? null : Steps(steps: Step.fromJsonList(json['data']));
}
