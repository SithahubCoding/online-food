import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryLocation {
  final double latitude;
  final double longitude;
  final String houseNumber;
  final String street;
  final String village;
  final String commune;
  final String district;
  final String city;
  final Timestamp updatedAt;

  DeliveryLocation({
    required this.latitude,
    required this.longitude,
    required this.houseNumber,
    required this.street,
    required this.village,
    required this.commune,
    required this.district,
    required this.city,
    required this.updatedAt,
  });

  LatLng get latLng => LatLng(latitude, longitude);

  factory DeliveryLocation.fromMap(Map<String, dynamic> map) {
    return DeliveryLocation(
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      houseNumber: map['houseNumber'] ?? '',
      street: map['street'] ?? '',
      village: map['village'] ?? '',
      commune: map['commune'] ?? '',
      district: map['district'] ?? '',
      city: map['city'] ?? '',
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'houseNumber': houseNumber,
      'street': street,
      'village': village,
      'commune': commune,
      'district': district,
      'city': city,
      'updatedAt': updatedAt,
    };
  }
}
