// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:api_with_provider/model/favourite_model.dart';
import 'package:api_with_provider/model/news_api_res_model.dart';
import 'package:api_with_provider/view/favourite_screen/favourite_screen.dart';
import 'package:flutter/material.dart';

class FavouriteScreenController with ChangeNotifier {
  List<FavouriteModel> favouriteList = [];

  addToFavourite(Article article, BuildContext context) {
    final isAlreadyFavourite =
        favouriteList.any((element) => element.article.title == article.title);
    if (isAlreadyFavourite) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
      log("Already in favourites");
    } else {
      favouriteList.add(FavouriteModel(article: article, isFavourite: true));
    }
    notifyListeners();
  }

  deleteFromFavourite(int index) {
    favouriteList.removeAt(index);
    notifyListeners();
  }
}
