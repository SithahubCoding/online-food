// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../controllers/cart_controllrt.dart';
// import '../controllers/payment_controller.dart';
// import './location_screen.dart';
// import './payment/payment_screen.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final CartController cartController = Get.put(CartController());
//   final PaymentController paymentController = Get.put(PaymentController());
//   final Color modernColor = const Color(0xFFFFC107);

//   @override
//   void initState() {
//     super.initState();
//     cartController.loadCartFromDB(); // Load cart on init
//   }

//   // Choose delivery location
//   void _chooseDeliveryLocation(BuildContext context) async {
//     final result = await Get.to(() => const DeliveryLocationScreen());
//     if (result != null && result is LatLng) {
//       cartController.setDeliveryLocation(result); // ✅ no await
//       Get.snackbar(
//         'Location Selected',
//         'Delivery location updated!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//     }
//   }

//   // Checkout
//   void _checkout() {
//     if (cartController.deliveryLocation.value == null) {
//       Get.snackbar(
//         'No Location',
//         'Please select delivery location before checkout!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//       return;
//     }

//     paymentController.setSubtotal(cartController.totalPrice);
//     Get.to(() => const PaymentScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: modernColor,
//         leading: const BackButton(),
//         title: const Text("Your Cart", style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//       body: Obx(() {
//         if (cartController.items.isEmpty) {
//           return const Center(child: Text("Your cart is empty"));
//         }

//         return ListView.builder(
//           itemCount: cartController.items.length,
//           itemBuilder: (context, index) {
//             final item = cartController.items[index];
//             final quantity = cartController.quantities[index];

//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               elevation: 4,
//               child: ListTile(
//                 leading: item.image.isNotEmpty
//                     ? Image.asset(item.image, width: 50, height: 50, fit: BoxFit.cover)
//                     : const Icon(Icons.fastfood, size: 50),
//                 title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text("\$${item.price.toStringAsFixed(2)} x $quantity"),
//                 trailing: SizedBox(
//                   width: 140,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.remove, color: Colors.red),
//                         onPressed: () {
//                           if (quantity > 1) {
//                             cartController.quantities[index] -= 1;
//                             cartController.update();
//                           } else {
//                             cartController.removeItem(index);
//                           }
//                         },
//                       ),
//                       Text("$quantity"),
//                       IconButton(
//                         icon: const Icon(Icons.add, color: Colors.green),
//                         onPressed: () {
//                           cartController.quantities[index] += 1;
//                           cartController.update();
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.redAccent),
//                         onPressed: () => cartController.removeItem(index),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//       bottomNavigationBar: Obx(() {
//         final subtotal = cartController.totalPrice;
//         final deliveryFee = cartController.deliveryFee.value;
//         final total = subtotal + deliveryFee;

//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
//             ],
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Subtotal"),
//                   Text("\$${subtotal.toStringAsFixed(2)}"),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Delivery Fee"),
//                   Text("\$${deliveryFee.toStringAsFixed(2)}"),
//                 ],
//               ),
//               if (cartController.deliveryLocation.value != null)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.location_on, color: Colors.red),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           "Delivery: (${cartController.deliveryLocation.value!.latitude.toStringAsFixed(4)}, ${cartController.deliveryLocation.value!.longitude.toStringAsFixed(4)})",
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               const Divider(thickness: 1, height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("\$${total.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: modernColor,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       onPressed: () => _chooseDeliveryLocation(context),
//                       child: const Text(
//                         "Choose Delivery Location",
//                         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       onPressed: _checkout,
//                       child: const Text(
//                         "Checkout",
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/cart_controllrt.dart';
import '../controllers/payment_controller.dart';
import './location_screen.dart';
import './payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());
  final paymentController = Get.put(PaymentController());
  final modernColor = const Color(0xFFFFC107);

  @override
  void initState() {
    super.initState();
    cartController.loadCart(); // load cart from SQLite
  }

  void _chooseDeliveryLocation() async {
    final result = await Get.to(() => const DeliveryLocationScreen());
    if (result != null && result is LatLng) {
      cartController.setDeliveryLocation(result);
      Get.snackbar(
        'Location Selected',
        'Delivery location updated!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void _checkout() async {
    if (cartController.deliveryLocation.value == null) {
      Get.snackbar(
        'No Location',
        'Please select delivery location!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Sync to PaymentController
    paymentController.setSubtotal(cartController.totalPrice);
    paymentController.deliveryFee.value = cartController.deliveryFee.value;
    paymentController.setDeliveryLocation(cartController.deliveryLocation.value!);

    Get.to(() => const PaymentScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: modernColor, title: const Text("Your Cart")),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }

        return ListView.builder(
          itemCount: cartController.items.length,
          itemBuilder: (context, index) {
            final item = cartController.items[index];
            final quantity = cartController.quantities[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: item.image.isNotEmpty ? Image.asset(item.image, width: 50, height: 50) : null,
                title: Text(item.name),
                subtitle: Text("\$${item.price} x $quantity"),
                trailing: SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.remove, color: Colors.red),
                          onPressed: () => cartController.removeItem(index)),
                      Text("$quantity"),
                      IconButton(
                          icon: const Icon(Icons.add, color: Colors.green),
                          onPressed: () => cartController.addToCart(item, 1)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        final subtotal = cartController.totalPrice;
        final deliveryFee = cartController.deliveryFee.value;
        final total = subtotal + deliveryFee;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _priceRow("Subtotal", subtotal),
              _priceRow("Delivery Fee", deliveryFee),
              _priceRow("Total", total, isBold: true),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: modernColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _chooseDeliveryLocation,
                      child: const Text("Choose Location", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _checkout,
                      child: const Text("Checkout", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _priceRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
          Text("\$${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
        ],
      ),
    );
  }
}
