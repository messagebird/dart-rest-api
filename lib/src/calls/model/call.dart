import 'dart:convert';

import '../../util.dart';

/// Class encapsulating a [Call] object.
class Call {
  /// The unique ID of the [Call].
  final String id;

  /// The status of the [Call]. See [CallStatus] for allowed values.
  final CallStatus status;

  /// The source number of the [Call], without leading `+`, ommited if not
  /// available
  final String source;

  /// The destination number of the [Call], without leading `+`, ommited if not
  /// available
  final String destination;

  /// The date-time the [Call] was created, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime createdAt;

  /// The date-time the [Call] was last updated, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime updatedAt;

  /// The date-time the [Call] ended, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime endedAt;

  /// Constructor.
  const Call({
    this.id,
    this.status,
    this.source,
    this.destination,
    this.createdAt,
    this.updatedAt,
    this.endedAt,
  });

  /// Construct a [Call] object from a json [String].
  factory Call.fromJson(String source) =>
      Call.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Call] object from a [Map].
  factory Call.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Call(
          id: map['id'],
          status: CallStatus.values.firstWhere(
              (status) => status.toString() == 'CallStatus.${map['status']}',
              orElse: () => null),
          source: map['source'],
          destination: map['destination'],
          createdAt: parseDate(map['createdAt']),
          updatedAt: parseDate(map['updatedAt']),
          endedAt: parseDate(map['endedAt']),
        );

  /// Get a json [String] representing the [Call].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'status': status?.toString()?.replaceAll('CallStatus.', ''),
        'source': source,
        'destination': destination,
        'createdAt': createdAt?.toString(),
        'updatedAt': updatedAt?.toString(),
        'endedAt': endedAt?.toString(),
      };

  /// Get a list of [Call] objects from a json [String].
  static List<Call> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Call>[]
          : List.from(json.decode(source)['data'] ?? json.decode(source))
              .map((j) => Call.fromMap(j))
              .toList();
}

/// Enumeration of [CallStatus] statusses.
enum CallStatus {
  /// [Call] is queued.
  queued,

  /// [Call] is starting.
  starting,

  /// [Call] is ongoing.
  ongoing,

  /// [Call] has ended.
  ended
}
