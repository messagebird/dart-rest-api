class Credentials {
  final String API_TEST_KEY;
  final String API_LIVE_KEY;
  final int MSISDN;

  const Credentials(this.API_TEST_KEY, this.API_LIVE_KEY, {this.MSISDN});

  factory Credentials.from(Map<String, dynamic> envV) {
    final testKey = envV['API_TEST_KEY'].toString();
    final liveKey = envV['API_LIVE_KEY'].toString();
    final msisdn = int.tryParse(envV['MSISDN']);

    if (testKey == null || liveKey == null) {
      throw ArgumentError('No API keys found in environment variables. '
          'Check your setup.');
    }

    return Credentials(testKey, liveKey, MSISDN: msisdn);
  }

  bool get hasMSISDN => MSISDN != null;

  bool get arePresent => API_TEST_KEY != null && API_LIVE_KEY != null;
}
