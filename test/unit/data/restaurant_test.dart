import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/network/restaurant.dart';

void main() {
  group("Parsing JSON from network response to Restaurant Model", () {
    test("when json null, should return default value", () {
      // arrange
      // act
      final restaurant = RestaurantNetwork.fromJson(null);

      // assert
      expect(restaurant.id, "");
      expect(restaurant.name, "");
      expect(restaurant.desciption, "");
      expect(restaurant.pictureId, "");
      expect(restaurant.city, "");
      expect(restaurant.rating, 0.0);
    });

    test(
        "when json not complete, should return model based on json with default value for incomplete",
        () {
      // arrange
      Map<String, dynamic> json = {
        "id": "this is id",
        "name": "this is name",
        "city": "Banda Aceh"
      };

      // act
      final restaurant = RestaurantNetwork.fromJson(json);

      // assert
      expect(restaurant.id, json["id"]);
      expect(restaurant.name, json["name"]);
      expect(restaurant.desciption, "");
      expect(restaurant.pictureId, "");
      expect(restaurant.city, json["city"]);
      expect(restaurant.rating, 0.0);
    });

    test("when json complete, should return model based on json value", () {
      // arrange
      Map<String, dynamic> json = {
        "id": "this is id",
        "name": "this is name",
        "description": "this is description",
        "pictureId": "somepictureid",
        "city": "Banda Aceh",
        "rating": 10,
      };

      // act
      final restaurant = RestaurantNetwork.fromJson(json);

      // assert
      expect(restaurant.id, json["id"]);
      expect(restaurant.name, json["name"]);
      expect(restaurant.desciption, json["description"]);
      expect(restaurant.pictureId, json["pictureId"]);
      expect(restaurant.city, json["city"]);
      expect(restaurant.rating, json["rating"]);
    });
  });
}
