import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();

  if (!serviceEnabled) {
    return Future.error('Enable location on your device settings');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error(
          'Allow Weather application to access device location');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Device location permission is disabled. The app won\'t work');
  }

  return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
}
