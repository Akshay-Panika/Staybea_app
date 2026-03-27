import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  var city = ''.obs;
  var state = ''.obs;

  var isLocationLoaded = false.obs;
  var isLoading = false.obs; // 🔥 ADD THIS

  Future<void> fetchLocation() async {
    try {
      isLoading.value = true; // 🔥 start loading
      isLocationLoaded.value = false;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Error", "Enable location service");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission", "Permission denied");
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Permission", "Open settings and allow permission");
        await Geolocator.openAppSettings();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude.value,
        longitude.value,
      );

      if (placemarks.isNotEmpty) {
        city.value = placemarks.first.locality ?? '';
        state.value = placemarks.first.administrativeArea ?? '';
      }

      isLocationLoaded.value = true;

    } catch (e) {
      Get.snackbar("Error", "Failed to get location");
    } finally {
      isLoading.value = false; // 🔥 stop loading
    }
  }
}