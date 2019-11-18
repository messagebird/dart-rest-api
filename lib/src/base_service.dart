import 'dart:convert';
import 'dart:io' show File, Platform;
import 'dart:html' show HttpRequest;
import 'package:yaml/yaml.dart';

class BaseService {
  static const VOICE_ENDPOINT = 'voice.messagebird.com';
  static String CONVERSATIONS_ENDPOINT = 'conversations.messagebird.com';

  final String _accessKey;
  final int timeout;
  final List<String> features;
  final Map<String, String> pubspec =
      Map.castFrom(loadYaml(File('./pubspec.yaml').readAsStringSync()));

  BaseService(String accessKey, {int timeout = 5000, List<String> features})
      : _accessKey = accessKey,
        this.timeout = timeout,
        this.features = features {
    if (features != null &&
        features.contains('ENDABLE_CONVERSATIONSAPI_WHATSAPP_SANDBOX')) {
      CONVERSATIONS_ENDPOINT = 'whatsapp-sandbox.messagebird.com';
    }
  }

  Future httpRequest(Map<String, dynamic> params) async {
    Map options = {};
    String body;
    HttpRequest request;

    options = {
      'hostname': params['hostname'] ?? 'rest.messagebird.com',
      'path': params['path'],
      'method': params['method'],
      'headers': {
        'Authorization': 'AccessKey $_accessKey',
        'User-Agent':
            'MessageBird/ApiClient/${pubspec['version']} Dart/${Platform.version}'
      }
    };

    if (options['method'] == 'POST' ||
        options['method'] == 'PUT' ||
        options['method'] == 'PATCH') {
      body = jsonEncode(params['params']);
      options['headers']['Content-Type'] = 'application/json';
      options['headers']['Content-Length'] = body.codeUnits.length;
    } else {
      // GET
      options['path'] = params['params']
          ? Uri(
              scheme: 'http',
              path: options['path'],
              queryParameters: params['params'])
          : Uri(scheme: 'http', path: options['path']);
    }

    options['headers'] =
        (options['headers'] ?? {}).addAll(params['headers'] ?? {});

    return HttpRequest.request(options['hostname'] + options['path'],
            method: options['method'], requestHeaders: options['headers'])
        .timeout(Duration(milliseconds: timeout), onTimeout: request.abort)
        .catchError((error) {
      return (error.message == 'ECONNRESET')
          ? Future.error('request timeout')
          : Future.error('request failed: ${error.message}');
    }).then((request) {
      Map data;

      if (request.status == 204) {
        return Future.value(null);
      }

      try {
        data = jsonDecode(request.response);

        if (data['errors'] ?? false) {
          final List<String> clientErrors = data['errors'].map((error) =>
              '${error.description} (code ${error.code}${error.parameter ? ', parameter ${error.parameter}' : ''})');
          return Future.error('api error(s): ${clientErrors.join(', ')}');
        }
      } catch (error) {
        return Future.error('response failed');
      }
      return Future.value(data);
    });
  }
}
