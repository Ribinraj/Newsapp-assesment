import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Endpoints {
  static const String baseurl = 'https://news.kumudam.com/api/posts/';
}

class NewsRepo {
  static Future<http.Response> fetchNews({
    int limit = 20,
    int offset = 0,
    String order = 'id',
    String orderType = 'desc',
  }) async {
    var client = http.Client();
    try {
      final url = Uri.parse(
          '${Endpoints.baseurl}?limit=$limit&offset=$offset&order=$order&orderType=$orderType');
      var response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint('status code: ${response.statusCode}');
      return response;
    } catch (e) {
      debugPrint('Error: $e');
      log(e.toString());
      rethrow;
    } finally {
      client.close();
    }
  }
}
