import 'package:flutter/material.dart';
import 'package:flutter_news_app/src/models/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

class NewsService extends ChangeNotifier {
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey = 'b4f3e387ab11449aac21c82791f05b06';
  List<Article> headline = [];
  bool _isLoading = true;
  Map<String, List<Article>> newsCategory = {};
  String _selectedCategory = 'business';
  List<Category> category = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  NewsService() {
    getTopHeadLines();

    for (var element in category) {
      newsCategory[element.name] = <Article>[];
    }
    getNewsByCategories(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getNewsByCategories(valor);
    notifyListeners();
  }

  get getSelectedCategory => newsCategory[selectedCategory];

  getTopHeadLines() async {
    final url = Uri.parse('$_baseUrl/top-headlines?apiKey=$_apiKey&country=us');

    final resp = await http.get(url);
    final data = NewsResponse.fromJson(resp.body);
    headline.addAll(data.articles);
    notifyListeners();
  }

  getNewsByCategories(categoryName) async {
    if (newsCategory[categoryName]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return newsCategory[categoryName];
    }
    final url = Uri.parse(
        '$_baseUrl/top-headlines?apiKey=$_apiKey&country=us&category=$categoryName');
    final resp = await http.get(url);
    final data = NewsResponse.fromJson(resp.body);
    newsCategory[categoryName]!.addAll(data.articles);
    _isLoading = false;
    notifyListeners();
    // print(data.articles[1].description);
  }
}
