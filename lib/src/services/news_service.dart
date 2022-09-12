import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/widgets.dart';
import 'package:fl_newsapp/src/models/news_models.dart';
import 'package:fl_newsapp/src/models/category_model.dart';

const _URL_NEWS = 'newsapi.org';
const _API_KEY = '7299a64596ac4ffbb10f059360870957';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology')
  ];

  Map<String, List<Article>> categoryArticles = {};

  String _selectedCategory = 'business';

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory]!;

  NewsService() {
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
  }

  getTopHeadlines() async {
    // https://newsapi.org/v2/top-headlines?country=it&apiKey=7299a64596ac4ffbb10f059360870957
    final url = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'apiKey': _API_KEY, 'country': 'it'});
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    final url = Uri.https(_URL_NEWS, '/v2/top-headlines',
        {'apiKey': _API_KEY, 'country': 'it', 'category': category});
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
