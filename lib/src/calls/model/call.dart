/// Class encapsulating a [Call] object.
class Call {
  /// The unique ID of the [Call].
  final String id;

  /// The status of the [Call]. Possible values: `queued`, `starting`,
  /// `ongoing`, `ended`.
  final Status status;

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
  Call(
      {this.id,
      this.status,
      this.source,
      this.destination,
      this.createdAt,
      this.updatedAt,
      this.endedAt});

  /// Construct a [Call] object from a [json] object.
  factory Call.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Call(
        id: json['id'].toString(),
        status: Status.values.firstWhere(
            (status) => status.toString() == 'Status.${json['status']}',
            orElse: () => null),
        source: json['source'].toString(),
        destination: json['destination'].toString(),
        createdAt: DateTime.parse(json['createdAt'].toString()),
        updatedAt: DateTime.parse(json['updatedAt'].toString()),
        endedAt: DateTime.parse(json['endedAt'].toString()));
  }

  /// Get a list of [Call] objects from a [json] object
  static List<Call> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Call.fromJson(j)).toList();
}

/// Enumeration of [Call] statusses.
enum Status {
  /// [Call] is queued.
  queued,

  /// [Call] is starting.
  starting,

  /// [Call] is ongoing.
  ongoing,

  /// [Call] has ended.
  ended
}
