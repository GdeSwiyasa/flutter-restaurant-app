import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/data/model/search_model.dart';

class ApiService {
  static const String _apiUrl = 'https://restaurant-api.dicoding.dev/';
  var client = http.Client();

  Future<RestaurantList> getListRestaurant() async {
    final response = await client.get(Uri.parse(_apiUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed');
    }
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    final response = await client.get(Uri.parse(_apiUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed');
    }
  }

  Future<Search> getSearchRestaurant(String key) async {
    final response = await client.get(Uri.parse(_apiUrl + "search?q=" + key));
    if (response.statusCode == 200) {
      return Search.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed');
    }
  }
}
