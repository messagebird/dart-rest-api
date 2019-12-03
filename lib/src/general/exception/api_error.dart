/// Class encapsulating an API error.
class ApiError extends Error {
  /// The API error code.
  final int code;

  /// The API error message.
  final String message;

  /// The API error description.
  final String description;

  /// Constructor.
  ApiError({this.code, this.message, this.description});

  /// Construct an API error from a [Map].
  factory ApiError.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : ApiError(
          code: map['code'],
          message: map['message'],
          description: map['description']);
}
