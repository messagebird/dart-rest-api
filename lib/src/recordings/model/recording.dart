import 'dart:convert';

import '../../util.dart';

/// A [Recording] describes a voice recording of a leg. You can initiate a
/// recording of a leg by having a step in your callflow with the record action
/// set.
///
/// This is an object representing a [Recording].
class Recording {
  /// The unique ID of the recording.
  final String id;

  /// The format of the recording. Supported formats are: `wav`.
  final String format;

  /// The type of the recording. See [RecordingType] for allowed values.
  final RecordingType type;

  /// The ID of the leg that the recording belongs to.
  final String legId;

  /// The status of the recording. See [RecordingStatus] for allowed values.
  final RecordingStatus status;

  /// The duration of the recording in seconds.
  final int duration;

  /// The date-time the call was created, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime createdAt;

  /// The date-time the call was last updated, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime updatedAt;

  /// A map with [HATEOAS](https://en.wikipedia.org/wiki/HATEOAS) links related
  /// to the object. This includes the `file` link that has the URI for
  /// downloading the wave file of the recording.
  final Map<String, Uri> links;

  /// Constructor.
  const Recording(
      {this.id,
      this.format,
      this.type,
      this.legId,
      this.status,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.links});

  /// Construct a [Recording] object from a json [String].
  factory Recording.fromJson(String source) =>
      Recording.fromMap(json.decode(source));

  /// Construct a [Recording] object from a [Map].
  factory Recording.fromMap(Map<String, dynamic> map) {
    final Map data = map['data'] == null ? map : map['data'][0];
    return Recording(
        id: data['id'],
        format: data['format'],
        type: RecordingType.values.firstWhere(
            (type) =>
                type.toString() ==
                'RecordingType.${data['type']}'.replaceAll(' ', '_'),
            orElse: () => null),
        legId: data['legId'],
        status: RecordingStatus.values.firstWhere(
            (status) =>
                status.toString() ==
                'RecordingStatus.${data['status']}'.replaceAll(' ', '_'),
            orElse: () => null),
        duration: parseInt(data['duration']),
        createdAt: parseDate(data['createdAt']),
        updatedAt: parseDate(data['updatedAt']),
        links: Map<String, Uri>.from(
            map['_links'].map((key, uri) => MapEntry(key, Uri.parse(uri)))));
  }

  /// Get a json [String] representing the [Recording].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'format': format,
        'type': type?.toString()?.replaceAll('RecordingType.', ''),
        'legId': legId,
        'status': status?.toString()?.replaceAll('RecordingStatus.', ''),
        'duration': duration,
        'createdAt': createdAt?.toString(),
        'updatedAt': updatedAt?.toString(),
        '_links': Map<String, String>.from(
            links.map((key, uri) => MapEntry(key, uri.toString())))
      };

  /// Get a list of [Recording] objects from a json [String].
  static List<Recording> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Recording>[]
          : List.from(json.decode(source)['data'])
              .map((j) => Recording.fromMap(j))
              .toList();
}

/// Enumeration of [Recording] statusses.
enum RecordingStatus {
  /// [Recording] is initialised.
  initialised,

  /// [Recording] is in progress.
  recording,

  /// [Recording] is done.
  done,

  /// [Recording] has failed.
  failed
}

/// Enumeration of [Recording] types.
enum RecordingType {
  /// Result of a `record` step.
  ivr,

  /// Result of a `transfer` step recording.
  transfer,

  /// Full call recording.
  call
}
