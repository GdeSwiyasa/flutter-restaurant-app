import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/database_service.dart';
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/favorite_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseService databaseService;

  FavoriteProvider({required this.databaseService}) {
    getFavorite();
  }

  ResultState _data = ResultState.hasData;
  String _message = '';
  List<RestaurantFavorit> _listFavorite = [];

  ResultState get data => _data;
  String get message => _message;
  List<RestaurantFavorit> get listFavorite => _listFavorite;

  void getFavorite() async {
    _listFavorite = await databaseService.getFavorite();
    if (_listFavorite.isNotEmpty) {
      _data = ResultState.hasData;
    } else {
      _data = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantDetail restautant) async {
    try {
      await databaseService.insertFavorit(restautant);
      getFavorite();
    } catch (e) {
      _data = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(RestaurantDetail restaurant) async {
    final favorite = await databaseService.getFavoriteById(restaurant.id);
    return favorite.isNotEmpty;
  }

  void removeFav(RestaurantDetail restaurant) async {
    try {
      await databaseService.removeFavorite(restaurant.id);
      getFavorite();
    } catch (e) {
      _data = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}

enum ResultState { loading, noData, hasData, error }
