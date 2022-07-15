import 'package:ditonton/security/security_http_shared.dart';
import 'package:http/http.dart' as http;

class SecurityHttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await SecurityHttpShared.createSecureHttpClient();

  static http.Client? _clientInstance;

  static http.Client get client => _clientInstance ?? http.Client();

  static Future<void> init() async {
    _clientInstance = await _instance;
  }
}
