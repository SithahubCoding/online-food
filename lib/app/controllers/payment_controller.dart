
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../models/payment_method.dart';
// import 'cart_controller.dart';

// class PaymentController extends GetxController {
//   var subtotal = 0.0.obs;
//   var deliveryFee = 5.0.obs;
//   var deliveryLocation = Rx<LatLng?>(null);
//   var selectedMethod = Rx<PaymentMethod?>(null);

//   double get total => subtotal.value + deliveryFee.value;

//   void setSubtotal(double value) => subtotal.value = value;
//   void setDeliveryLocation(LatLng location) => deliveryLocation.value = location;
//   void selectPaymentMethod(PaymentMethod method) => selectedMethod.value = method;

//   Future<void> saveOrder() async {
//     final cartController = Get.find<CartController>();
//     if (deliveryLocation.value == null || selectedMethod.value == null) return;

//     final payment = PaymentModel(
//       subtotal: subtotal.value,
//       deliveryFee: deliveryFee.value,
//       total: total,
//       deliveryLocation: deliveryLocation.value!,
//       method: selectedMethod.value!,
//       transactionId: '${selectedMethod.value!.name}-${DateTime.now().millisecondsSinceEpoch}',
//       createdAt: DateTime.now(),
//     );

//     await cartController.saveOrder(payment.method.name, payment.transactionId);
//     await cartController.clearCart();
//   }
// }

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/payment_method.dart';
import 'cart_controller.dart';

/// Basic PaymentModel definition
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
}

class PaymentController extends GetxController {
  // Observables
  var subtotal = 0.0.obs;
  var deliveryFee = 5.0.obs;
  var deliveryLocation = Rx<LatLng?>(null);
  var selectedMethod = Rx<PaymentMethod?>(null);
  var orderDate = Rxn<DateTime>(); // <-- New observable for order date

  // Total amount
  double get total => subtotal.value + deliveryFee.value;

  // Setters
  void setSubtotal(double value) => subtotal.value = value;
  void setDeliveryLocation(LatLng location) => deliveryLocation.value = location;
  void selectPaymentMethod(PaymentMethod method) => selectedMethod.value = method;

  // Save order
  Future<void> saveOrder() async {
    final cartController = Get.find<CartController>();
    if (deliveryLocation.value == null || selectedMethod.value == null) return;

    final now = DateTime.now();

    final payment = PaymentModel(
      subtotal: subtotal.value,
      deliveryFee: deliveryFee.value,
      total: total,
      deliveryLocation: deliveryLocation.value!,
      method: selectedMethod.value!,
      transactionId: '${selectedMethod.value!.name}-${now.millisecondsSinceEpoch}',
      createdAt: now,
    );

    // Save the order date so screens can access it
    orderDate.value = now;

    // Save order to cart controller (or DB)
    await cartController.saveOrder(payment.method.name, payment.transactionId);

    // Clear cart after saving
    await cartController.clearCart();
  }
}
