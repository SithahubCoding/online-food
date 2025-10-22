// lib/controllers/payment_controller.dart
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/payment_method.dart';
import 'cart_controllrt.dart';

class PaymentController extends GetxController {
  var subtotal = 0.0.obs;
  var deliveryFee = 5.0.obs;
  var deliveryLocation = Rx<LatLng?>(null);
  var selectedMethod = Rx<PaymentMethod?>(null);

  double get total => subtotal.value + deliveryFee.value;

  void setSubtotal(double value) => subtotal.value = value;
  void setDeliveryLocation(LatLng location) => deliveryLocation.value = location;
  void selectPaymentMethod(PaymentMethod method) => selectedMethod.value = method;

  /// Save order to DB or Firestore
  Future<void> saveOrder() async {
    final cartController = Get.find<CartController>();
    if (deliveryLocation.value == null || selectedMethod.value == null) return;

    final payment = PaymentModel(
      subtotal: subtotal.value,
      deliveryFee: deliveryFee.value,
      total: total,
      deliveryLocation: deliveryLocation.value!,
      method: selectedMethod.value!,
      transactionId: '${selectedMethod.value!.name}-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );

    // Save to local DB
    await cartController.saveOrder(payment.method.name, payment.transactionId);

    // Optional: Save to Firestore
    // await FirebaseFirestore.instance.collection('orders').add(payment.toMap());

    // Clear cart
    await cartController.clearCart();
  }
}
