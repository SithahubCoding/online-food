import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LatLng?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          print("❌ GPS service not enabled");
          return null;
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print("❌ Location permission denied");
          return null;
        }
      }

      final currentLocation = await _location.getLocation();
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        print("✅ Got location: ${currentLocation.latitude}, ${currentLocation.longitude}");
        return LatLng(currentLocation.latitude!, currentLocation.longitude!);
      }
      return null;
    } catch (e) {
      print("❌ Error getting location: $e");
      return null;
    }
  }
}
