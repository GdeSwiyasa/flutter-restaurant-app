import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_provider.dart';
import 'package:restaurant_app/data/model/search_model.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    _fetchSearchRestaurant();
  }

  late Search _searchRestaurant;
  late ResultData _data;
  String _message = "";
  String key = "";

  Search get searchRestaurant => _searchRestaurant;
  ResultData get data => _data;
  String get message => _message;

  Future<dynamic> _fetchSearchRestaurant() async {
    if (key != "") {
      try {
        _data = ResultData.loading;
        notifyListeners();
        final result = await apiService.getSearchRestaurant(key);
        if (result.restaurants.isEmpty) {
          _data = ResultData.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _data = ResultData.hasData;
          notifyListeners();
          return _searchRestaurant = result;
        }
      } catch (e) {
        _data = ResultData.error;
        notifyListeners();
        return _message = 'Error : $e';
      }
    } else {
      _data = ResultData.noKey;
      notifyListeners();
      return _message = 'No Key';
    }
  }

  void addSearchKey(String key) {
    this.key = key;
    _fetchSearchRestaurant();
    notifyListeners();
  }
}

enum ResultData { loading, noData, hasData, error, noKey }
