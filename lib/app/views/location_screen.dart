// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../services/location_service.dart';

// class DeliveryLocationScreen extends StatefulWidget {
//   const DeliveryLocationScreen({super.key});

//   @override
//   State<DeliveryLocationScreen> createState() => _DeliveryLocationScreenState();
// }

// class _DeliveryLocationScreenState extends State<DeliveryLocationScreen> {
//   final LocationService _locationService = LocationService();
//   GoogleMapController? mapController;

//   LatLng? _selectedLocation;
//   final Set<Marker> _markers = {};
//   bool _isLoading = true;

//   static const LatLng _defaultLocation = LatLng(11.5564, 104.9282);

//   @override
//   void initState() {
//     super.initState();
//     _loadCurrentLocation();
//   }

//   Future<void> _loadCurrentLocation() async {
//     setState(() { _isLoading = true; });
//     final current = await _locationService.getCurrentLocation();
//     final initialLocation = current ?? _defaultLocation;

//     if (!mounted) return;

//     setState(() {
//       _selectedLocation = initialLocation;
//       _markers.clear();
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('userLocation'),
//           position: initialLocation,
//           infoWindow: const InfoWindow(title: 'Your Location'),
//         ),
//       );
//       _isLoading = false;
//     });

//     if (current == null) {
//       Get.snackbar(
//         'Location Error',
//         'Unable to get your precise location. Please select one manually.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.shade600,
//         colorText: Colors.white,
//       );
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _onTap(LatLng position) {
//     setState(() {
//       _selectedLocation = position;
//       _markers.clear();
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('delivery'),
//           position: position,
//           draggable: true,
//           infoWindow: const InfoWindow(title: 'Delivery Location'),
//           onDragEnd: (newPos) => _selectedLocation = newPos,
//         ),
//       );
//     });
//   }

//   void _saveLocation() {
//     if (_selectedLocation != null) {
//       Get.back(result: _selectedLocation);
//       Get.snackbar(
//         'Success',
//         'Delivery location selected!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } else {
//       Get.snackbar(
//         'Error',
//         'Please select a location first!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//     }
//   }

//   Future<void> _useMyCurrentLocation() async {
//     setState(() { _isLoading = true; });
//     final current = await _locationService.getCurrentLocation();
//     if (current != null) {
//       setState(() {
//         _selectedLocation = current;
//         _markers.clear();
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('delivery'),
//             position: current,
//             draggable: true,
//             infoWindow: const InfoWindow(title: 'Delivery Location'),
//             onDragEnd: (newPos) => _selectedLocation = newPos,
//           ),
//         );
//         _isLoading = false;
//       });
//       mapController?.animateCamera(CameraUpdate.newLatLng(current));
//       Get.snackbar(
//         'Location Updated',
//         'Using your current location!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } else {
//       setState(() { _isLoading = false; });
//       Get.snackbar(
//         'Error',
//         'Unable to get your current location!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFFC107),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Get.back(),
//         ),
//         title: const Text(
//           "Set Delivery Location",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(icon: const Icon(Icons.save), onPressed: _saveLocation),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: _selectedLocation ?? _defaultLocation,
//                       zoom: 15,
//                     ),
//                     onMapCreated: _onMapCreated,
//                     markers: _markers,
//                     onTap: _onTap,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                     zoomControlsEnabled: false,
//                   ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.my_location, color: Colors.white),
//                 label: const Text(
//                   "Use My Current Location",
//                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFFFC107),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 onPressed: _useMyCurrentLocation,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// } correct
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../services/location_service.dart';
// import '../services/delivery_location_service.dart';

// class DeliveryLocationScreen extends StatefulWidget {
//   const DeliveryLocationScreen({super.key});

//   @override
//   State<DeliveryLocationScreen> createState() => _DeliveryLocationScreenState();
// }

// class _DeliveryLocationScreenState extends State<DeliveryLocationScreen> {
//   final LocationService _locationService = LocationService();
//   final DeliveryLocationService _deliveryService = DeliveryLocationService();
//   GoogleMapController? mapController;

//   LatLng? _selectedLocation;
//   final Set<Marker> _markers = {};
//   bool _isLoading = true;

//   final _formKey = GlobalKey<FormState>();
//   final _houseController = TextEditingController();
//   final _streetController = TextEditingController();
//   final _villageController = TextEditingController();
//   final _communeController = TextEditingController();
//   final _districtController = TextEditingController();
//   final _cityController = TextEditingController();

//   static const LatLng _defaultLocation = LatLng(11.5564, 104.9282);

//   @override
//   void initState() {
//     super.initState();
//     _loadCurrentLocation();
//     _loadSavedLocation();
//   }

//   Future<void> _loadCurrentLocation() async {
//     setState(() => _isLoading = true);
//     final current = await _locationService.getCurrentLocation();
//     setState(() {
//       _selectedLocation = current ?? _defaultLocation;
//       _markers.clear();
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('delivery'),
//           position: _selectedLocation!,
//           draggable: true,
//           onDragEnd: (pos) => _selectedLocation = pos,
//         ),
//       );
//       _isLoading = false;
//     });
//   }

//   Future<void> _loadSavedLocation() async {
//     final data = await _deliveryService.getLocation();
//     if (data != null) {
//       setState(() {
//         _selectedLocation = LatLng(data['latitude'], data['longitude']);
//         _markers.clear();
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('delivery'),
//             position: _selectedLocation!,
//             draggable: true,
//             onDragEnd: (pos) => _selectedLocation = pos,
//           ),
//         );
//         _houseController.text = data['houseNumber'] ?? '';
//         _streetController.text = data['street'] ?? '';
//         _villageController.text = data['village'] ?? '';
//         _communeController.text = data['commune'] ?? '';
//         _districtController.text = data['district'] ?? '';
//         _cityController.text = data['city'] ?? '';
//       });
//     }
//   }

//   void _saveLocation() async {
//     if (_selectedLocation == null) {
//       Get.snackbar('Error', 'Please select location on map!');
//       return;
//     }
//     await _deliveryService.saveLocation(
//       location: _selectedLocation!,
//       houseNumber: _houseController.text,
//       street: _streetController.text,
//       village: _villageController.text,
//       commune: _communeController.text,
//       district: _districtController.text,
//       city: _cityController.text,
//     );
//     Get.snackbar('Success', 'Delivery location saved!');
//     Get.back(result: _selectedLocation);
//   }

//   @override
//   void dispose() {
//     _houseController.dispose();
//     _streetController.dispose();
//     _villageController.dispose();
//     _communeController.dispose();
//     _districtController.dispose();
//     _cityController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Set Delivery Location'),
//         actions: [
//           IconButton(icon: const Icon(Icons.save), onPressed: _saveLocation),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: _selectedLocation ?? _defaultLocation,
//                       zoom: 15,
//                     ),
//                     onMapCreated: (controller) => mapController = controller,
//                     markers: _markers,
//                     onTap: (pos) {
//                       setState(() {
//                         _selectedLocation = pos;
//                         _markers.clear();
//                         _markers.add(
//                           Marker(
//                             markerId: const MarkerId('delivery'),
//                             position: pos,
//                             draggable: true,
//                             onDragEnd: (p) => _selectedLocation = p,
//                           ),
//                         );
//                       });
//                     },
//                     myLocationEnabled: true,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Form(
//                       key: _formKey,
//                       child: ListView(
//                         children: [
//                           TextFormField(
//                             controller: _houseController,
//                             decoration: const InputDecoration(
//                               labelText: 'House Number',
//                             ),
//                           ),
//                           TextFormField(
//                             controller: _streetController,
//                             decoration: const InputDecoration(
//                               labelText: 'Street',
//                             ),
//                           ),
//                           TextFormField(
//                             controller: _villageController,
//                             decoration: const InputDecoration(
//                               labelText: 'Village/Sangkat',
//                             ),
//                           ),
//                           TextFormField(
//                             controller: _communeController,
//                             decoration: const InputDecoration(
//                               labelText: 'Commune/Quarter',
//                             ),
//                           ),
//                           TextFormField(
//                             controller: _districtController,
//                             decoration: const InputDecoration(
//                               labelText: 'District/Khan',
//                             ),
//                           ),
//                           TextFormField(
//                             controller: _cityController,
//                             decoration: const InputDecoration(
//                               labelText: 'City/Province',
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           ElevatedButton(
//                             onPressed: _saveLocation,
//                             child: const Text('Save Delivery Location'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
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
    setState(() => _isLoading = true);
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
          icon: BitmapDescriptor.defaultMarkerWithHue(
            Theme.of(context).brightness == Brightness.dark
                ? BitmapDescriptor.hueAzure
                : BitmapDescriptor.hueOrange,
          ),
        ),
      );
      _isLoading = false;
    });

    if (current == null) {
      _showSnackbar(
        'Location Error',
        'Unable to get your precise location. Please select one manually.',
        isError: true,
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
          icon: BitmapDescriptor.defaultMarkerWithHue(
            Theme.of(context).brightness == Brightness.dark
                ? BitmapDescriptor.hueAzure
                : BitmapDescriptor.hueOrange,
          ),
        ),
      );
    });
  }

  void _saveLocation() {
    if (_selectedLocation != null) {
      Get.back(result: _selectedLocation);
      _showSnackbar('Success', 'Delivery location selected!');
    } else {
      _showSnackbar('Error', 'Please select a location first!', isError: true);
    }
  }

  Future<void> _useMyCurrentLocation() async {
    setState(() => _isLoading = true);
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
            icon: BitmapDescriptor.defaultMarkerWithHue(
              Theme.of(context).brightness == Brightness.dark
                  ? BitmapDescriptor.hueAzure
                  : BitmapDescriptor.hueOrange,
            ),
          ),
        );
        _isLoading = false;
      });
      mapController?.animateCamera(CameraUpdate.newLatLng(current));
      _showSnackbar('Location Updated', 'Using your current location!');
    } else {
      setState(() => _isLoading = false);
      _showSnackbar('Error', 'Unable to get your current location!', isError: true);
    }
  }

  void _showSnackbar(String title, String message, {bool isError = false}) {
    final brightness = Theme.of(context).brightness;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError
          ? Colors.redAccent
          : (brightness == Brightness.dark ? Colors.blueGrey.shade700 : Colors.green),
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.orange : Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Set Delivery Location",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: isDark ? Colors.white : Colors.white),
            onPressed: _saveLocation,
          ),
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
                    mapToolbarEnabled: false,
                    mapType: isDark ? MapType.hybrid : MapType.normal,
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
                  backgroundColor: isDark ? Colors.orange : const Color(0xFF142338),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _useMyCurrentLocation,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
    );
  }
}
