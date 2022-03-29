import 'package:restaurant_app/data/model/restaurant_model.dart';

class Search {
  Search({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
