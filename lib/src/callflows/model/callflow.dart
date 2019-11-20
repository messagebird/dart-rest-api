import 'step.dart';

/// Class encapsulating a call flow object.
class Callflow {
  /// The unique ID of the call flow.
  final String id;

  /// The title of the call flow.
  final String title;

  /// Says whether a full call recording is enabled on this call flow, the
  /// default value for this attribute is `false`.
  final bool record;

  /// An array of step objects. The sequence of the array items describe the
  /// order of execution, where the first item will be executed first, than
  /// the second, etcetera.
  final List<Step> steps;

  /// The `default` attribute says whether the call flow will be used when no
  /// call flow was found for an inbound number. Only one default call flow is
  /// allowed.
  ///
  /// Please note that in the [MessageBird API](https://developers.messagebird.com/api/voice-calling#call-flows),
  /// this attribute is called `default`, but due to Dart's `default` keyword,
  /// the name `isDefault` is used here.
  final bool isDefault;

  /// The date-time the call flow was created, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime createdAt;

  /// The date-time the call flow was last updated, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime updatedAt;

  /// Constructor.
  Callflow(
      {this.id,
      this.title,
      this.record,
      this.steps,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  /// Construct a call flow object from a [json] object.
  factory Callflow.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Callflow(
        id: json['id'].toString(),
        title: json['title'].toString(),
        record: json['record'] == 'true',
        steps: Step.fromJsonList(json['steps']),
        isDefault: json['default'] == 'true',
        createdAt: DateTime.parse(json['createdAt'].toString()),
        updatedAt: DateTime.parse(json['updatedAt'].toString()));
  }

  /// Get a list of call flows from a [json] object.
  static List<Callflow> fromJsonList(Object json) {
    if (json == null) {
      return null;
    }
    return (json as List).map((j) => Callflow.fromJson(j)).toList();
  }
}
