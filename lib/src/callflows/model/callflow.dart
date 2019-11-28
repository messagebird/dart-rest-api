import 'dart:convert';

import 'package:messagebird_dart/src/general/util.dart';

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
  const Callflow({
    this.id,
    this.title,
    this.record = false,
    this.steps,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  /// Construct a [Callflow] object from a json [String].
  factory Callflow.fromJson(String source) =>
      Callflow.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Callflow] object from a [Map].
  factory Callflow.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Callflow(
          id: map['id'],
          title: map['title'],
          record: map['record'].toString() == 'true',
          steps: map['steps'] == null
              ? null
              : List<Step>.from(map['steps'].map((step) => Step.fromMap(step))),
          isDefault: map['default'].toString() == 'true',
          createdAt: parseDate(map['createdAt']),
          updatedAt: parseDate(map['updatedAt']));

  /// Get a json [String] representing the [Callflow].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'record': record,
        'steps': steps == null
            ? null
            : List<dynamic>.from(steps.map((step) => step.toMap())),
        'default': isDefault,
        'createdAt': createdAt?.toString(),
        'updatedAt': updatedAt?.toString(),
      };

  /// Get a list of [Callflow] objects from a json [String].
  static List<Callflow> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Callflow>[]
          : List.from(json.decode(source)['data'] ?? json.decode(source))
              .map((j) => Callflow.fromMap(j))
              .toList();
}
