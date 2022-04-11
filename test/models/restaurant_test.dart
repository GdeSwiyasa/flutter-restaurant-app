import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

void main() {
  test('Restaurant from json should return a complete restaurant object', () {
    final restaurant = Restaurant.fromJson({
      'id': "idTest",
      'name': "nameTest",
      'city': "cityTest",
      'description': "descriptionTest",
      'pictureId': "pictureIdTest",
      'rating': 4.7,
    });
    expect(restaurant.id, "idTest");
    expect(restaurant.name, "nameTest");
    expect(restaurant.city, "cityTest");
    expect(restaurant.description, "descriptionTest");
    expect(restaurant.pictureId, "pictureIdTest");
    expect(restaurant.rating, 4.7);
  });
}
