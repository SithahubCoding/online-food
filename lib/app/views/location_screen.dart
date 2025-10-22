import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';

class DeliveryLocationScreen extends StatefulWidget {
  const DeliveryLocationScreen({super.key});

  @override
  State<DeliveryLocationScreen> createState() => _DeliveryLocationScreenState();
}

class _DeliveryLocationScreenState extends State<DeliveryLocationScreen> {
  final LocationService _locationService = LocationService();
  GoogleMapController? mapController;

  LatLng? _selectedLocation;
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  static const LatLng _defaultLocation = LatLng(11.5564, 104.9282);

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    setState(() { _isLoading = true; });
    final current = await _locationService.getCurrentLocation();
    final initialLocation = current ?? _defaultLocation;

    if (!mounted) return;

    setState(() {
      _selectedLocation = initialLocation;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('userLocation'),
          position: initialLocation,
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
      _isLoading = false;
    });

    if (current == null) {
      Get.snackbar(
        'Location Error',
        'Unable to get your precise location. Please select one manually.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent.withOpacity(0.9),
        colorText: Colors.white,
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('delivery'),
          position: position,
          draggable: true,
          infoWindow: const InfoWindow(title: 'Delivery Location'),
          onDragEnd: (newPos) => _selectedLocation = newPos,
        ),
      );
    });
  }

  void _saveLocation() {
    if (_selectedLocation != null) {
      Get.back(result: _selectedLocation);
      Get.snackbar(
        'Success',
        'Delivery location selected!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please select a location first!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  Future<void> _useMyCurrentLocation() async {
    setState(() { _isLoading = true; });
    final current = await _locationService.getCurrentLocation();
    if (current != null) {
      setState(() {
        _selectedLocation = current;
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('delivery'),
            position: current,
            draggable: true,
            infoWindow: const InfoWindow(title: 'Delivery Location'),
            onDragEnd: (newPos) => _selectedLocation = newPos,
          ),
        );
        _isLoading = false;
      });
      mapController?.animateCamera(CameraUpdate.newLatLng(current));
      Get.snackbar(
        'Location Updated',
        'Using your current location!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      setState(() { _isLoading = false; });
      Get.snackbar(
        'Error',
        'Unable to get your current location!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC107),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Set Delivery Location",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveLocation),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _selectedLocation ?? _defaultLocation,
                      zoom: 15,
                    ),
                    onMapCreated: _onMapCreated,
                    markers: _markers,
                    onTap: _onTap,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.my_location, color: Colors.white),
                label: const Text(
                  "Use My Current Location",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _useMyCurrentLocation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
