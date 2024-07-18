import 'package:base_code/module/favorite_screen/favorite_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxString searchQuery = ''.obs;
  RxList selectedCards = [].obs;
  RxList carDataList = [].obs;
  RxString currentPlaceName = 'Loading...'.obs;
  final RxString _currentCityName = 'Loading...'.obs;
  bool _isDisposed = false;
  StreamSubscription<Position>? _positionStream;

  final FavoriteController favoriteController = Get.put(FavoriteController());

  bool isFavorite(Map<String, dynamic> car) {
    return favoriteController.isFavorite(car);
  }

  void toggleSelected(int index) {
    selectedCards.clear();
    selectedCards.add(index);
  }

  void toggleFavorite(Map<String, dynamic> car) {
    if (isFavorite(car)) {
      favoriteController.removeFavorite(car);
    } else {
      favoriteController.addFavorite(car);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getCurrentLocation();
  }

  @override
  void onClose() {
    _isDisposed = true;
    _positionStream?.cancel();
    super.onClose();
  }

  Future<void> _getCurrentLocation() async {
    _positionStream =
        Geolocator.getPositionStream().listen((Position position) {
          if (_isDisposed) return;
          _updatePosition(position);
        });
  }

  void _updatePosition(Position position) async {
    if (_isDisposed) return;
    _getLocationDetails(position.latitude, position.longitude);
    if (_isDisposed) return;
    List<Placemark> placeMarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks.isNotEmpty
        ? placeMarks.first
        : const Placemark(name: 'Unknown Place', locality: 'Unknown City');
    currentPlaceName.value = place.name ?? 'Unknown Place';
    _currentCityName.value = place.locality ?? 'Unknown City';
    if (place.subLocality != null && place.subLocality!.isNotEmpty) {
      currentPlaceName.value = '$currentPlaceName, ${place.subLocality}';
    }
  }

  Future<void> _getLocationDetails(double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks =
      await placemarkFromCoordinates(latitude, longitude);
      if (_isDisposed) return;
      Placemark place = placeMarks[0];
      currentPlaceName.value = place.name ?? 'Unknown Place';
      _currentCityName.value = place.locality ?? 'Unknown City';
      if (place.subLocality != null && place.subLocality!.isNotEmpty) {
        currentPlaceName.value = ' $currentPlaceName,$_currentCityName';
      }
    } catch (e) {
      if (_isDisposed) return;
      currentPlaceName.value = 'Unknown Place';
      _currentCityName.value = 'Unknown City';
    }
  }
}
