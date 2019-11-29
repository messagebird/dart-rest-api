import 'dart:convert';

import 'package:messagebird_dart/src/general/util.dart';

/// Class encapsulating a [Transcription].
class Transcription {
  /// The unique ID of the transcription.
  final String id;

  /// The ID of the recording that the transcription belongs to.
  final String recordingId;

  /// In case an error occurred while executing the transcription request, it
  /// appears here.
  final String error;

  /// The date-time the transcription was created/requested, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime createdAt;

  /// The date-time the transcription was last updated, in RFC 3339 format
  /// (e.g. `2017-03-06T13:34:14Z`).
  final DateTime updatedAt;

  /// A map with [HATEOAS](https://en.wikipedia.org/wiki/HATEOAS) links related
  /// to the object. This includes the `file` link that has the URI for
  /// downloading the text transcription of a recording.
  final Map<String, Uri> links;

  /// Constructor.
  Transcription({
    this.id,
    this.recordingId,
    this.error,
    this.createdAt,
    this.updatedAt,
    this.links,
  });

  /// Construct a [Transcription] object from a json [String].
  factory Transcription.fromJson(String source) =>
      Transcription.fromMap(json.decode(source));

  /// Construct a [Transcription] object from a [Map].
  factory Transcription.fromMap(Map<String, dynamic> map) {
    final Map data = map['data'] == null ? map : map['data'][0];
    return Transcription(
        id: data['id'],
        recordingId: data['recordingId'],
        error: data['error'],
        createdAt: parseDate(data['createdAt']),
        updatedAt: parseDate(data['updatedAt']),
        links: Map<String, Uri>.from(
            map['_links'].map((key, uri) => MapEntry(key, Uri.parse(uri)))));
  }

  /// Get a json [String] representing the [Transcription].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'recordingId': recordingId,
        'error': error,
        'createdAt': createdAt?.toString(),
        'updatedAt': updatedAt?.toString(),
        '_links': Map<String, String>.from(
            links.map((key, uri) => MapEntry(key, uri.toString())))
      };

  /// Get a list of [Transcription] objects from a json [String].
  static List<Transcription> fromJsonList(String source) => source == null
      ? null
      : ((json.decode(source).containsKey('totalCount') &&
                  json.decode(source)['totalCount'] == 0) ||
              json.decode(source).containsKey('pagination') &&
                  json.decode(source)['pagination']['totalCount'] == 0)
          ? <Transcription>[]
          : List.from(json.decode(source)['data'] ?? json.decode(source))
              .map((j) => Transcription.fromMap(j))
              .toList();
}
