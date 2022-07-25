import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkService {
  static Future<http.Response> get(Uri url,
      {Map<String, String>? headers}) async {
    final response = await http.get(url, headers: headers);

    if (kDebugMode) {
      print("Url $url");
      print("Request ${response.request}");
      print("Response ${response.body}");
    }

    return response;
  }
}
