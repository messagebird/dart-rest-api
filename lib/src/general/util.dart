/// Parse an RFC3339 [DateTime] to a RFC3339 Datetime [String] without
/// nanoseconds.
DateTime parseDate(Object date) {
  String string;

  if (date == null) {
    return null;
  } else if (date is DateTime) {
    string = date.toString();
  } else if (date is String) {
    string = date;
  } else {
    throw Exception('parseDate requires a String or a DateTime as input');
  }

  string = string.length > 27
      ? string.substring(0, 26) + string[string.length - 1]
      : string;

  return DateTime.parse(string);
}
