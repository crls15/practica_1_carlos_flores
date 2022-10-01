import 'dart:convert';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:practica_1_carlos_flores/utils/secret.dart';

class HttpRequests {
  static final HttpRequests _httpReq = HttpRequests._internal();

  factory HttpRequests() {
    return _httpReq;
  }

  HttpRequests._internal();

  Future<Response> postRequest(record_file_base_64) async {
    Map<String, dynamic> body = {
      "api_token": "${auddioKey}",
      "audio": "${record_file_base_64}",
      "return": 'apple_music,spotify,deezer',
      "method": 'recognize',
    };
    return await http.post(
      Uri.parse('https://api.audd.io/'),
      body: json.encode(body),
    );
  }
}
