import 'step.dart';

/// Class encapsulating a [Callflow] object.
class Callflow {
  /// The unique ID of the [Callflow].
  final String id;

  /// The title of the [Callflow].
  final String title;

  /// Says whether a full call recording is enabled on this [Callflow], the
  /// default value for this attribute is `false`.
  final bool record;

  /// A list of [Step] objects. The sequence of the list items describe the
  /// order of execution, where the first item will be executed first, than
  /// the second, etcetera.
  final List<Step> steps;

  /// The `default` attribute says whether the [Callflow] will be used when no
  /// call flow was found for an inbound number. Only one default call flow is
  /// allowed.
  ///
  /// Please note that in the [MessageBird API](https://developers.messagebird.com/api/voice-calling#call-flows),
  /// this attribute is called `default`, but due to Dart's `default` keyword,
  /// the name `isDefault` is used here.
  final bool isDefault;

  /// The date-time the [Callflow] was created, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime createdAt;

  /// The date-time the [Callflow] was last updated, in RFC 3339 format
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

  /// Construct a [Callflow] object from a [json] object.
  factory Callflow.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Callflow(
          id: json['id'].toString(),
          title: json['title'].toString(),
          record: json['record'] == 'true',
          steps: Step.fromJsonList(json['steps']),
          isDefault: json['default'] == 'true',
          createdAt: DateTime.parse(json['createdAt']),
          updatedAt: DateTime.parse(json['updatedAt']));

  /// Get a list of [Callflow] objects from a [json] object.
  static List<Callflow> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Callflow.fromJson(j)).toList();

  /// Get a json object representing the [Callflow]
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (id != null) {
      json.addAll({'id': id});
    }
    if (title != null) {
      json.addAll({'title': title});
    }
    if (record != null) {
      json.addAll({'record': record});
    }
    if (steps != null) {
      json.addAll({'steps': steps.map((step) => step.toJson()).toList()});
    }
    if (isDefault != null) {
      json.addAll({'default': isDefault});
    }
    if (createdAt != null) {
      json.addAll({'createdAt': createdAt.toString()});
    }
    if (updatedAt != null) {
      json.addAll({'updatedAt': updatedAt.toString()});
    }
    return json;
  }
}
