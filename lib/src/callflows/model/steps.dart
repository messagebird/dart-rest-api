import 'step.dart';

/// Class encapsulating a list of steps.
class Steps {
  /// Listing of all [steps].
  final List<Step> steps;

  /// Constructor.
  Steps({this.steps});

  /// Construct a step object from a [json] object.
  factory Steps.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Steps(steps: Step.fromJsonList(json['data']));
  }
}
