/// Class encapsulating an API error.
class ApiError {
  /// The API error code.
  final int code;

  /// The API error message.
  final String message;

  /// Constructor.
  ApiError({this.code, this.message});

  /// Construct an API error from a [Map].
  factory ApiError.fromMap(Map<String, dynamic> json) => json == null
      ? null
      : ApiError(code: json['code'], message: json['message']);
}
