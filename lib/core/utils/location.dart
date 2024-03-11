import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkLocationPermission() async {
  bool permissionIsGranted = await Permission.location.isGranted;
  if (!permissionIsGranted) {
    permissionIsGranted =
        await Permission.location.request() == PermissionStatus.granted;
  }

  return permissionIsGranted;
}

Future<Either<String, Position>> getCurrentLocation() async {
  final bool isGranted = await checkLocationPermission();
  if (isGranted) {
    final bool isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return const Left('Please enable location access');
    return Right(await Geolocator.getCurrentPosition());
  } else {
    return const Left('Please grant location permission to proceed');
  }
}

Future<Placemark> getAddressFromLocation(
    double latitude, double longitude) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
  return placemarks.first;
}

Future<Either<String, Placemark>> getAddressFromCurrentLocation() async {
  final Either<String, Position> result = await getCurrentLocation();
  if (result.isLeft()) {
    return Left((result as Left).value);
  }
  final Position position = (result as Right).value;
  return Right(
      await getAddressFromLocation(position.latitude, position.longitude));
}
