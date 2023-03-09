import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longtitude;
  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low)
          .timeout(
        const Duration(seconds: 15),
      );
      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      throw 'Something foes wrong: $e';
    }
  }
}
