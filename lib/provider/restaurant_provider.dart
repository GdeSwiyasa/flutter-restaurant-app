import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_provider.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurant();
  }

  late RestaurantList _restaurantList;
  late ResultData _data;
  String _message = "";

  RestaurantList get restaurantList => _restaurantList;
  ResultData get data => _data;
  String get message => _message;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _data = ResultData.loading;
      notifyListeners();
      final result = await apiService.getListRestaurant();
      if (result.restaurants.isEmpty) {
        _data = ResultData.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _data = ResultData.hasData;
        notifyListeners();
        return _restaurantList = result;
      }
    } catch (e) {
      _data = ResultData.error;
      notifyListeners();
      return _message = 'Error : $e';
    }
  }
}

enum ResultData { loading, noData, hasData, error }
