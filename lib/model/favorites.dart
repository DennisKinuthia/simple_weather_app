import 'dart:collection';

import 'package:flutter/material.dart';

class Favourites extends ChangeNotifier {
  final List<String> _favoriteCities = [];

  UnmodifiableListView<String> get cities =>
      UnmodifiableListView(_favoriteCities);

  void addCityToFavs(String city) {
    _favoriteCities.add(city);
    notifyListeners();
  }

  void removeCityFromFavs(String city) {
    _favoriteCities.removeWhere((element) => element == city);
    notifyListeners();
  }

  void clearFavs() {
    _favoriteCities.clear();
    notifyListeners();
  }
}
