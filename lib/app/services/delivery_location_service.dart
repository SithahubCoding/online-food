import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryLocationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveLocation({
    required LatLng location,
    String? houseNumber,
    String? street,
    String? village,
    String? commune,
    String? district,
    String? city,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _db.collection('delivery_locations').doc(user.uid).set({
      'latitude': location.latitude,
      'longitude': location.longitude,
      'houseNumber': houseNumber ?? '',
      'street': street ?? '',
      'village': village ?? '',
      'commune': commune ?? '',
      'district': district ?? '',
      'city': city ?? '',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getLocation() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _db.collection('delivery_locations').doc(user.uid).get();
    if (!doc.exists) return null;
    return doc.data();
  }
}
