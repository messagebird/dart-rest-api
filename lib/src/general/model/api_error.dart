/// Class encapsulating an API error.
class ApiError {
  /// The API error code.
  final int code;

  /// The API error description.
  final String description;

  /// The API error parameter.
  final String parameter;

  /// Constructor.
  ApiError({this.code, this.description, this.parameter});

  /// Construct an API error from a json object.
  factory ApiError.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return ApiError(
        code: json['code'],
        description: json['description'],
        parameter: json['parameter']);
  }
}
