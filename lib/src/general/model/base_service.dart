import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io' show File, Platform;

import 'package:http/http.dart' show Response, Client, BaseClient;
import 'package:yaml/yaml.dart';

import '../exception/communication_problem.dart';
import 'api_error.dart';

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
  BaseService(this._accessKey, {int timeout, List<String> features})
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
      return Future.value(_client
          .delete(
            _getUrl(path, hostname: hostname),
            headers: headers,
          )
          .timeout(Duration(milliseconds: _timeout))
          .then(_handleResponse));
    } on Exception catch (e) {
      // Problem with sending the request
      throw CommunicationProblem(e.toString());
    }
  }

  /// Send a http GET request to [path]
  /// The parameter [hostname] is optional and defaults back to
  /// 'rest.messagebird.com'. The parameter [body] is also optional and can be
  /// used to provide parameters to the requests
  Future<Response> get(String path,
      {String hostname, Map<String, dynamic> body}) {
    final Map<String, String> headers = _getHeaders();
    try {
      return Future.value(_client
          .get(
              _getUrl(
                  '$path'
                  // ignore: lines_longer_than_80_chars
                  '${body == null ? '' : _createQuery(body)}',
                  hostname: hostname),
              headers: headers)
          .timeout(Duration(milliseconds: _timeout))
          .then(_handleResponse));
    } on Exception catch (e) {
      // Problem with sending the request
      throw CommunicationProblem(e.toString());
    }
  }

  /// Send a http PATCH request to [path]
  /// The parameter [hostname] is optional and defaults back to
  /// 'rest.messagebird.com'. The parameter [body] is also optional and can
  /// contain body parameters.
  Future<Response> patch(String path,
      {String hostname, Map<String, dynamic> body}) async {
    final Map<String, String> headers = _getHeaders();
    try {
      return Future.value(_client
          .patch(_getUrl(path, hostname: hostname),
              headers: headers, body: body == null ? {} : json.encode(body))
          .timeout(Duration(milliseconds: _timeout))
          .then(_handleResponse));
    } on Exception catch (e) {
      // Problem with sending the request
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
    try {
      return Future.value(_client
          .post(_getUrl(path, hostname: hostname),
              headers: headers, body: body == null ? {} : json.encode(body))
          .timeout(Duration(milliseconds: _timeout))
          .then(_handleResponse));
    } on Exception catch (e) {
      // Problem with sending the request
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
    try {
      return Future.value(_client
          .put(
            _getUrl(path, hostname: hostname),
            headers: headers,
            body: body == null ? {} : json.encode(body),
          )
          .timeout(Duration(milliseconds: _timeout))
          .then(_handleResponse));
    } on Exception catch (e) {
      // Problem with sending the request
      throw CommunicationProblem(e.toString());
    }
  }

  String _createQuery(Map<String, dynamic> parameters) {
    if (parameters == null || parameters.isEmpty) {
      return '';
    }
    final List<String> nvps = [];
    parameters.forEach((k, v) {
      if (v != null) {
        nvps.add('${Uri.encodeComponent(k.toString())}='
            '${Uri.encodeComponent(v.toString())}');
      }
    });
    return (nvps.isEmpty) ? '' : '?${nvps.join('&')}';
  }

  Map<String, String> _getHeaders() {
    final Map<String, String> headers = {};
    if (_accessKey != null) {
      headers.addAll({'Authorization': 'AccessKey $_accessKey'});
    }
    headers.addAll({
      'Accept': 'application/json',
      'User-Agent':
          'MessageBird/ApiClient/${_pubspec['version']} Dart/${Platform.version.split(' ')[0]}'
    });
    return headers;
  }

  String _getUrl(String path, {String hostname}) {
    String newHostname;
    if (path == null) {
      throw ArgumentError('Argument "path" cannot be null');
    }
    if (hostname != null) {
      newHostname =
          (!hostname.startsWith('https://') && !hostname.startsWith('http://'))
              ? 'https://$hostname'
              : hostname;
      if (newHostname.endsWith('/')) {
        newHostname = newHostname.substring(0, newHostname.length - 1);
      }
    } else {
      newHostname = 'https://rest.messagebird.com';
    }
    return newHostname + path;
  }

  Response _handleResponse(Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final ApiError apiError =
          ApiError.fromMap(json.decode(response.body)['errors'][0]);
      if (apiError.code != 20 && apiError.code != 13) {
        throw Exception('API error (code ${apiError.code}): '
            '${apiError.message ?? apiError.description ?? 'NO_MESSAGE'}');
      } else {
        return null;
      }
    }
    return response;
  }
}
