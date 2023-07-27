import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_task_flutter/model/news_model.dart';

class NewsApiProvider {
  Client client = Client();
  final String baseUrl =
      'https://64c23e2eeb7fd5d6ebcf7c39.mockapi.io/api/v1/news';
  String deleteSymbols(String s) {
    s = s.substring(1, s.length - 1);
    return s;
  }

  Future<List<News>> fetchNews() async {
    final response = await client.get(Uri.parse(baseUrl));
    return NewsModel.fromJson(json.decode(deleteSymbols(response.body))).news!;
  }
}
