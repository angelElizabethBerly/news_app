import 'package:api_with_provider/model/news_api_res_model.dart';
import 'package:flutter/material.dart';

class FavouriteModel with ChangeNotifier {
  Article article;
  bool isFavourite;

  FavouriteModel({required this.article, this.isFavourite = false});
}
