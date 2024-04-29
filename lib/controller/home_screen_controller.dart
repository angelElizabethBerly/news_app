import 'dart:convert';
import 'dart:developer';

import 'package:api_with_provider/model/news_api_res_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  int selectedCategoryindex = 0;
  NewsApiRestModel? newsApiCatResModel;

  List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  bool isLoading = false;
  NewsApiRestModel? newsApiRestModel;

  Future getCatData() async {
    isLoading = true;
    notifyListeners();

    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=${categories[selectedCategoryindex]}&apiKey=220fa64cb6a04208b4e9a71e73817f3a");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var decodedData = jsonDecode(res.body);
      newsApiCatResModel = NewsApiRestModel.fromJson(decodedData);
    } else {
      log("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  Future getData(String searchQuery) async {
    isLoading = true;
    notifyListeners();

    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchQuery&apiKey=220fa64cb6a04208b4e9a71e73817f3a");

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var decodedData = jsonDecode(res.body);
      newsApiRestModel = NewsApiRestModel.fromJson(decodedData);
    } else {
      log("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  onCategorySelection(int value) {
    selectedCategoryindex = value;
    notifyListeners();
    getCatData();
  }
}
