import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_provider.dart';
import 'package:restaurant_app/data/model/detail_model.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String idRestaurant;

  DetailProvider({
    required this.apiService,
    required this.idRestaurant,
  }) {
    _fetchDetailRestaurant();
  }

  late DetailRestaurant _detailRestaurant;
  late ResultData _data;
  String _message = "";

  DetailRestaurant get detailRestaurant => _detailRestaurant;
  ResultData get data => _data;
  String get message => _message;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _data = ResultData.loading;
      notifyListeners();
      final result = await apiService.getDetailRestaurant(idRestaurant);
      if (result.restaurant.name.isEmpty) {
        _data = ResultData.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _data = ResultData.hasData;
        notifyListeners();
        return _detailRestaurant = result;
      }
    } catch (e) {
      _data = ResultData.error;
      notifyListeners();
      return _message = 'Error : $e';
    }
  }
}

enum ResultData { loading, noData, hasData, error }
