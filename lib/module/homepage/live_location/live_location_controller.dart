import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../package/config_packages.dart';
class LiveLocationController extends GetxController{
  final Completer<GoogleMapController> controller = Completer();
  RxBool isLoading=false.obs;
  CameraPosition currentPosition = const CameraPosition(
    target: LatLng(10.0, 20.0),
    zoom: 15.0,
  );
  final RxString currentPlaceName = 'Loading...'.obs;
  final RxString currentCityName = 'Loading...'.obs;
  StreamSubscription<Position>? _positionStreamSubscription;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
    _startLocationUpdates();
  }
  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    updatePosition(position);
  }

  void _startLocationUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      updatePosition(position);
    });
  }

  void updatePosition(Position position) async {
      currentPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15.0,
      );
    getLocationDetails(position.latitude, position.longitude);

    final GoogleMapController controllers = await controller.future;
    controllers.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
  }

  Future<void> getLocationDetails(double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placeMarks[0];
        currentPlaceName.value = place.name ?? 'Unknown Place';
        currentCityName.value = place.locality ?? 'Unknown City';

        // Concatenate area name with street name
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          currentPlaceName.value = ' $currentPlaceName,$currentCityName';
        }
    } catch (e) {
        currentPlaceName.value = 'Unknown Place';
        currentCityName.value = 'Unknown City';
    }
  }

}