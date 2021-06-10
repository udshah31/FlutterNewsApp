import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:nepal_sansar/model/news.dart';

class NewsService {
  static const String url = "https://nepalsansar.com//wp-json/wp/v2/posts";

  static List<News> parseNews(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<News> news = list.map((data) => News.fromJson(data)).toList();
    return news;
  }

  static Future<List<News>> getHomeNews({int page = 1}) async {
    final response = await http
        .get(Uri.parse('$url?per_page=10&order_date=desc&page=$page'));
    if (response.statusCode == 200) {
      return compute(parseNews, response.body);
    } else if (response.statusCode == 400) {
      throw Exception("Not Found");
    } else {
      throw Exception("Something wrong");
    }
  }

  static Future<List<News>> getNews(
      {int page = 1}) async {
    final response = await http.get(Uri.parse(
        '$url?per_page=10&order_date=desc&page=$page&categories=1'));
    if (response.statusCode == 200) {
      return compute(parseNews, response.body);
    } else if (response.statusCode == 400) {
      throw Exception("Not Found");
    } else {
      throw Exception("Something wrong");
    }
  }

  static Future<List<News>> getPoliticsNews({int page = 1}) async {
    final response = await http.get(
        Uri.parse('$url?per_page=10&order_date=desc&page=$page&categories=3'));
    if (response.statusCode == 200) {
      return compute(parseNews, response.body);
    } else if (response.statusCode == 400) {
      throw Exception("Not Found");
    } else {
      throw Exception("Something wrong");
    }
  }
}
