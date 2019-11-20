/// Class encapsulating a [Groups] object.
class Groups {
  /// The total count of groups that contact belongs to.
  int totalCount;

  /// URL which can be used to retrieve list of groups contact belongs to.
  int href;

  /// Constructor.
  Groups({this.totalCount, this.href});

  /// Construct a [Groups] object from a [json] object.
  factory Groups.fromJson(Map<String, dynamic> json) => (json == null)
      ? null
      : Groups(totalCount: json['totalCount'], href: json['href']);
}
