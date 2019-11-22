import 'dart:convert';

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
  Callflow({
    this.id,
    this.title,
    this.record,
    this.steps,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  /// Construct a [Callflow] object from a json [String].
  factory Callflow.fromJson(String source) =>
      Callflow.fromMap(json.decode(source));

  /// Construct a [Callflow] object from a [Map].
  factory Callflow.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Callflow(
          id: map['id'],
          title: map['title'],
          record: map['record'],
          steps:
              List<Step>.from(map['steps']?.map((step) => Step.fromMap(step))),
          isDefault: map['isDefault'],
          createdAt: DateTime.parse(map['createdAt']),
          updatedAt: DateTime.parse(map['updatedAt']),
        );

  /// Get a json [String] representing the [Callflow].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'record': record,
        'steps': List<dynamic>.from(steps.map((step) => step.toMap())),
        'isDefault': isDefault,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'updatedAt': updatedAt.millisecondsSinceEpoch,
      };

  /// Get a list of [Callflow] objects from a [json] source.
  static List<Callflow> fromList(String source) => source == null
      ? null
      : List.from(json.decode(source)['data'])
          .map((j) => Callflow.fromMap(j))
          .toList();
}
