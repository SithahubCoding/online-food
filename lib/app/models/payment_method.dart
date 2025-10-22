// lib/models/payment_model.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum PaymentMethod { card, cod, qr }

class PaymentModel {
  final double subtotal;
  final double deliveryFee;
  final double total;
  final LatLng deliveryLocation;
  final PaymentMethod method;
  final String transactionId;
  final DateTime createdAt;

  PaymentModel({
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.deliveryLocation,
    required this.method,
    required this.transactionId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'deliveryLat': deliveryLocation.latitude,
      'deliveryLng': deliveryLocation.longitude,
      'method': method.name,
      'transactionId': transactionId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
