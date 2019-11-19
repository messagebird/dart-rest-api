import 'dart:async' show Future;
import 'dart:io' show File, Platform;

import 'package:http/http.dart' show Response, Client, BaseClient;
import 'package:yaml/yaml.dart';

import 'general/exception/communication_problem.dart';

/// Base service.
abstract class BaseService {
  /// The endpoint for voice messages.
  static const voiceEndpoint = 'voice.messagebird.com';

  /// The endpoint for conversations.
  static String conversationsEndpoint = 'conversations.messagebird.com';

  final BaseClient _client = Client();
  final String _accessKey;
  final int _timeout;
  final Map<String, String> _pubspec =
      Map.castFrom(loadYaml(File('./pubspec.yaml').readAsStringSync()));

  /// Constructor.
  BaseService(this._accessKey, {int timeout = 5000, List<String> features})
      : _timeout = (timeout == null) ? 5000 : timeout {
    if (features?.contains('ENDABLE_CONVERSATIONSAPI_WHATSAPP_SANDBOX') ??
        false) {
      conversationsEndpoint = 'whatsapp-sandbox.messagebird.com';
    }
  }

  /// Send a http DELETE request to [path]
  /// The parameter [hostname] is optional and defaults back to
  /// 'rest.messagebird.com'. The parameter [body] is also optional and can be
  /// used to provide parameters to the requests
  Future<Response> delete(String path,
      {String hostname, Map<String, dynamic> body}) {
    final Map<String, String> headers = _getHeaders();
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    try {
      return _client
          .delete(
            _getUrl(path, hostname: hostname),
            headers: headers,
          )
          .timeout(Duration(milliseconds: _timeout));
    } on Exception catch (e) {
      throw CommunicationProblem(e.toString());
    }
  }

  /// Send a http GET request to [path]
  /// The parameter [hostname] is optional and defaults back to
  /// 'rest.messagebird.com'. The parameter [body] is also optional and can be
  /// used to provide parameters to the requests
  Future<Response> get(String path,
      {String hostname, Map<String, dynamic> body}) {
    try {
      return _client
          .get(
              _getUrl(
                  '$path'
                  // ignore: lines_longer_than_80_chars
                  '${(body != null) ? _createQuery(body) : ''}',
                  hostname: hostname),
              headers: _getHeaders())
          .timeout(Duration(milliseconds: _timeout));
    } on Exception catch (e) {
      throw CommunicationProblem(e.toString());
    }
  }

  /// Send a http PATCH request to [path]
  /// The parameter [hostname] is optional and defaults back to
  /// 'rest.messagebird.com'. The parameter [body] is also optional and can
  /// contain body parameters.
  Future<Response> patch(String path, {String hostname, Object body}) {
    final Map<String, String> headers = _getHeaders();
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    try {
      return _client
          .patch(
            _getUrl(path, hostname: 'hostname'),
            headers: headers,
            body: (body is Map) ? _createBody(body) : body.toString(),
          )
          .timeout(Duration(milliseconds: _timeout));
    } on Exception catch (e) {
      throw CommunicationProblem(e.toString());
    }
  }

  /// Send a http POST request to [path]
  /// The parameter [hostname] is optional and defaults back to
  /// 'rest.messagebird.com'. The parameter [body] is also optional and can
  /// contain body parameters.
  Future<Response> post(String path,
      {String hostname, Map<String, dynamic> body}) {
    final Map<String, String> headers = _getHeaders();
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    try {
      return _client
          .post(_getUrl(path, hostname: hostname),
              headers: headers, body: _createBody(body))
          .timeout(Duration(milliseconds: _timeout));
    } on Exception catch (e) {
      throw CommunicationProblem(e.toString());
    }
  }

  /// Send a http PUT request to [path]
  /// The parameter [hostname] is optional and defaults back to
  /// 'rest.messagebird.com'. The parameter [body] is also optional and can
  /// contain body parameters.
  Future<Response> put(String path,
      {String hostname, Map<String, dynamic> body}) {
    final Map<String, String> headers = _getHeaders();
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    try {
      return _client
          .put(
            _getUrl('path', hostname: 'hostname'),
            headers: headers,
            body: _createBody(body),
          )
          .timeout(Duration(milliseconds: _timeout));
    } on Exception catch (e) {
      throw CommunicationProblem(e.toString());
    }
  }

  String _createBody(Map<String, String> parameters) {
    if (parameters == null || parameters.isEmpty) {
      return '';
    }
    final List<String> nvps = [];
    parameters.forEach((k, v) {
      nvps.add('${Uri.encodeComponent(k)}=${Uri.encodeComponent(v)}');
    });
    return nvps.join('&');
  }

  String _createQuery(Map<String, String> parameters) {
    if (parameters == null || parameters.isEmpty) {
      return '';
    }
    final List<String> nvps = [];
    parameters.forEach((k, v) {
      if (v != null) {
        nvps.add('${Uri.encodeComponent(k)}=${Uri.encodeComponent(v)}');
      }
    });
    return (nvps.isEmpty) ? '' : '?${nvps.join('&')}';
  }

  Map<String, String> _getHeaders() {
    final Map<String, String> headers = {};
    if (_accessKey != null) {
      headers.addAll({'Authorization': 'Accesskey $_accessKey'});
    }
    headers.addAll({
      'User-Agent':
          'MessageBird/ApiClient/${_pubspec['version']} Dart/${Platform.version}'
    });
    return headers;
  }

  String _getUrl(String path, {String hostname}) {
    String _hostname;
    if (path == null) {
      throw ArgumentError('Argument "path" cannot be null');
    }
    if (hostname != null) {
      if (!hostname.startsWith('https://') && !hostname.startsWith('http://')) {
        _hostname = 'https://$hostname';
      }
      if (hostname.endsWith('/')) {
        _hostname = hostname.substring(0, hostname.length - 1);
      }
    } else {
      _hostname = 'https://rest.messagebird.com';
    }
    return _hostname + path;
  }
}
