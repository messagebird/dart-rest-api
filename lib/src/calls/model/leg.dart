import 'dart:convert';

import 'package:messagebird_dart/src/general/util.dart';

/// Class encapsulating a [Leg] object, the connection between the caller and
/// the receiver.
class Leg {
  /// The unique ID of the leg.
  final String id;

  /// The unique ID of the call that this leg belongs to.
  final String callId;

  /// The number/SIP/Client URL that is making the connection.
  final String source;

  /// The number/SIP/Client URL that a connection is made to.
  final String destination;

  /// The status of the leg. See [LegStatus] for allowed values.
  final LegStatus status;

  /// The direction of the leg, indicating if it's an incoming connection or
  /// outgoing (e.g. for transferring a call). See [LegDirection] for allowed
  /// values.
  final LegDirection direction;

  /// The cost of the leg. The amount relates to the `currency` parameter.
  final double cost;

  /// The three-letter currency code (ISO 4217) related to the cost of the leg.
  final String currency;

  /// The duration of the leg, in seconds.
  final int duration;

  /// The date-time the leg was created, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime createdAt;

  /// The date-time the leg was last updated, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime updatedAt;

  /// The date-time the leg was answered, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime answeredAt;

  /// The date-time the leg ended, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime endedAt;

  /// Constructor.
  Leg({
    this.id,
    this.callId,
    this.source,
    this.destination,
    this.status,
    this.direction,
    this.cost,
    this.currency,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.answeredAt,
    this.endedAt,
  });

  /// Construct a [Leg] object from a json [String].
  factory Leg.fromJson(String source) =>
      Leg.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Leg] object from a [Map].
  factory Leg.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Leg(
          id: map['id'],
          callId: map['callId'],
          source: map['source'],
          destination: map['destination'],
          status: LegStatus.values.firstWhere(
              (status) => status.toString() == 'LegStatus.${map['status']}',
              orElse: () => null),
          direction: LegDirection.values.firstWhere(
              (direction) =>
                  direction.toString() == 'LegDirection.${map['direction']}',
              orElse: () => null),
          cost: double.tryParse(map['cost'].toString()),
          currency: map['currency'],
          duration: int.tryParse(map['duration'].toString()),
          createdAt: parseDate(map['createdAt']),
          updatedAt: parseDate(map['updatedAt']),
          answeredAt: parseDate(map['answeredAt']),
          endedAt: parseDate(map['endedAt']),
        );

  /// Get a json [String] representing the [Leg].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'callId': callId,
        'source': source,
        'destination': destination,
        'status': status?.toString()?.replaceAll('LegStatus.', ''),
        'direction': direction,
        'cost': cost,
        'currency': currency,
        'duration': duration,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'answeredAt': answeredAt?.toIso8601String(),
        'endedAt': endedAt?.toIso8601String(),
      };

  /// Get a list of [Leg] objects from a json [String].
  static List<Leg> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Leg>[]
          : List.from(json.decode(source)['data'] ?? json.decode(source))
              .map((j) => Leg.fromMap(j))
              .toList();
}

/// Enumeration of [Leg] connection statusses.
enum LegStatus {
  /// Call is starting.
  starting,

  /// Phone is ringing.
  ringing,

  /// Call is ongoing.
  ongoing,

  /// Receiver is busy.
  busy,

  /// Receiver did not answer.
  // ignore: constant_identifier_names
  no_answer,

  /// Call failed.
  failed,

  /// Caller or receiver hung up.
  hangup
}

/// Enumeration of [Leg] directions
enum LegDirection {
  /// The call is incoming.
  incoming,

  /// The call is outgoing.
  outgoing
}
