import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology')
  ];
  String _selectedCategory = 'business';
  Map<String, List<Article>> categoryArticles = {};

  final _api = "https://newsapi.org/v2";
  final _key = "64428e1de3c84d8f9afba5d4b3945e9f";

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((category) {
      this.categoryArticles[category.name] = [];
    });
  }
  get selectedCategory => this._selectedCategory;
  set selectedCategory(String value) {
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get articlesByCategory =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = Uri.parse("$_api/top-headlines?apiKey=$_key&country=us");
    final response = await http.get(url);
    final newsData = newsResponseFromJson(response.body);
    this.headlines.addAll(newsData.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0)
      return this.categoryArticles[category];

    final url = Uri.parse(
        "$_api/top-headlines?apiKey=$_key&country=us&category=$category");
    final response = await http.get(url);
    final newsData = newsResponseFromJson(response.body);
    this.categoryArticles[category].addAll(newsData.articles);
    notifyListeners();
  }
}
