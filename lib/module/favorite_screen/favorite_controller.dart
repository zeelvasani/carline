import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var favoriteCars = <Map<String, dynamic>>[].obs;

  void addFavorite(Map<String, dynamic> car) {
    favoriteCars.add(car);
  }

  void removeFavorite(Map<String, dynamic> car) {
    favoriteCars.removeWhere((favCar) => favCar['name'] == car['name']);
  }

  bool isFavorite(Map<String, dynamic> car) {
    return favoriteCars.any((favCar) => favCar['name'] == car['name']);
  }
}
