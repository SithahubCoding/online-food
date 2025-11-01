
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../app/controllers/cart_controller.dart';
// import '../../app/controllers/payment_controller.dart';
// import '../views/location_screen.dart';
// import '../views/payment/payment_screen.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final CartController cartController = Get.put(CartController());
//   final paymentController = Get.put(PaymentController());

//   final Color primaryColor = const Color(0xFF1E88E5); // Blue
//   final Color accentColor = const Color(0xFFFFC107); // Amber

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _chooseDeliveryLocation() async {
//     final result = await Get.to(() => const DeliveryLocationScreen());
//     if (result != null && result is LatLng) {
//       cartController.setDeliveryLocation(result);
//       Get.snackbar(
//         'Location Selected',
//         'Delivery location updated!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.shade600,
//         colorText: Colors.white,
//       );
//     }
//   }

//   void _checkout() {
//     if (cartController.deliveryLocation.value == null) {
//       Get.snackbar(
//         'No Location',
//         'Please select delivery location!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     // Sync to PaymentController
//     paymentController.setSubtotal(cartController.totalPrice);
//     paymentController.deliveryFee.value = cartController.deliveryFee.value;
//     paymentController.setDeliveryLocation(
//       cartController.deliveryLocation.value!,
//     );

//     Get.to(() => const PaymentScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: const Text(
//           "Your Cart 🛒",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Obx(() {
//         if (cartController.items.isEmpty) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.shopping_cart_outlined,
//                   size: 80,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Your cart is feeling light!",
//                   style: TextStyle(fontSize: 18, color: Colors.grey),
//                 ),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.only(top: 8, bottom: 120),
//           itemCount: cartController.items.length,
//           itemBuilder: (context, index) {
//             final item = cartController.items[index];
//             final quantity = cartController.quantities[index];

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       // Product Image: support network or asset
//                       Container(
//                         width: 70,
//                         height: 70,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child:
//                             (item.image.isNotEmpty &&
//                                 item.image.startsWith('http'))
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(
//                                   item.image,
//                                   fit: BoxFit.cover,
//                                   width: 70,
//                                   height: 70,
//                                   errorBuilder: (_, __, ___) =>
//                                       const Icon(Icons.image_not_supported),
//                                 ),
//                               )
//                             : (item.image.isNotEmpty)
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.asset(
//                                   item.image,
//                                   fit: BoxFit.cover,
//                                   width: 70,
//                                   height: 70,
//                                 ),
//                               )
//                             : const Center(
//                                 child: Icon(Icons.image_not_supported),
//                               ),
//                       ),
//                       const SizedBox(width: 12),
//                       // Product Details
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item.name,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               "\$${(item.price * quantity).toStringAsFixed(2)}",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: primaryColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               "\$${item.price.toStringAsFixed(2)} per unit",
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Quantity Controls + Delete
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(
//                               Icons.delete_outline,
//                               size: 24,
//                               color: Colors.red,
//                             ),
//                             onPressed: () => cartController.removeItem(index),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Row(
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.remove,
//                                     size: 20,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () {
//                                     if (quantity > 1) {
//                                       cartController.addToCart(item, -1);
//                                     } else {
//                                       cartController.removeItem(index);
//                                     }
//                                   },
//                                 ),
//                                 // 👇 ដាក់ Obx នៅទីនេះ
//                                 Obx(
//                                   () => Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 4.0,
//                                     ),
//                                     child: Text(
//                                       "${cartController.quantities[index]}",
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.add,
//                                     size: 20,
//                                     color: Colors.green,
//                                   ),
//                                   onPressed: () =>
//                                       cartController.addToCart(item, 1),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//       // Bottom Summary Bar
//       bottomNavigationBar: Obx(() {
//         if (cartController.items.isEmpty) return const SizedBox.shrink();

//         final subtotal = cartController.totalPrice;
//         final deliveryFee = cartController.deliveryFee.value;
//         final total = subtotal + deliveryFee;

//         return Container(
//           padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(color: const Color.fromARGB(37, 0, 0, 0), blurRadius: 5, spreadRadius: 1),
//             ],
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _priceRow("Subtotal", subtotal),
//               _priceRow("Delivery Fee", deliveryFee),
//               const Divider(height: 16, color: Colors.grey),
//               _priceRow(
//                 "Total",
//                 total,
//                 isBold: true,
//                 color: primaryColor,
//                 fontSize: 18,
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       icon: Icon(
//                         Icons.location_on_outlined,
//                         color: accentColor,
//                       ),
//                       label: const Text(
//                         "Location",
//                         style: TextStyle(color: Colors.black87),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         side: BorderSide(color: accentColor, width: 2),
//                         backgroundColor: accentColor,
//                       ),
//                       onPressed: _chooseDeliveryLocation,
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       icon: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: Colors.white,
//                       ),
//                       label: const Text(
//                         "Checkout",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 5,
//                       ),
//                       onPressed: _checkout,
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

//   Widget _priceRow(
//     String label,
//     double value, {
//     bool isBold = false,
//     Color color = Colors.black87,
//     double fontSize = 16,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
//               fontSize: fontSize,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           Text(
//             "\៛${value.toStringAsFixed(2)}",
//             style: TextStyle(
//               fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
//               fontSize: fontSize,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../app/controllers/cart_controller.dart';
// import '../../app/controllers/payment_controller.dart';
// import '../views/location_screen.dart';
// import '../views/payment/payment_screen.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   final CartController cartController = Get.put(CartController());
//   final paymentController = Get.put(PaymentController());

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _chooseDeliveryLocation() async {
//     final result = await Get.to(() => const DeliveryLocationScreen());
//     if (result != null && result is LatLng) {
//       cartController.setDeliveryLocation(result);
//       Get.snackbar(
//         'Location Selected',
//         'Delivery location updated!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.shade600,
//         colorText: Colors.white,
//       );
//     }
//   }

//   void _checkout() {
//     if (cartController.deliveryLocation.value == null) {
//       Get.snackbar(
//         'No Location',
//         'Please select delivery location!',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     paymentController.setSubtotal(cartController.totalPrice);
//     paymentController.deliveryFee.value = cartController.deliveryFee.value;
//     paymentController.setDeliveryLocation(cartController.deliveryLocation.value!);

//     Get.to(() => const PaymentScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     final primaryColor = isDarkMode ? Colors.orange : const Color(0xFF1E88E5);
//     final accentColor = isDarkMode ? Colors.orange : const Color(0xFFFFC107);
//     final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;
//     final backgroundColor = isDarkMode ? Colors.black87 : Colors.grey.shade100;

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: const Text(
//           "Your Cart 🛒",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Obx(() {
//         if (cartController.items.isEmpty) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
//                 SizedBox(height: 10),
//                 Text("Your cart is feeling light!", style: TextStyle(fontSize: 18, color: Colors.grey)),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.only(top: 8, bottom: 140),
//           itemCount: cartController.items.length,
//           itemBuilder: (context, index) {
//             final item = cartController.items[index];
//             final quantity = cartController.quantities[index];

//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               child: Card(
//                 color: cardColor,
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 70,
//                         height: 70,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: (item.image.isNotEmpty && item.image.startsWith('http'))
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: Image.network(item.image, fit: BoxFit.cover),
//                               )
//                             : (item.image.isNotEmpty)
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.asset(item.image, fit: BoxFit.cover),
//                                   )
//                                 : const Center(child: Icon(Icons.image_not_supported)),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 4),
//                             Text("\$${(item.price * quantity).toStringAsFixed(2)}",
//                                 style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold)),
//                             Text("\$${item.price.toStringAsFixed(2)} per unit",
//                                 style: const TextStyle(fontSize: 12, color: Colors.grey)),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.delete_outline, size: 24, color: Colors.red),
//                             onPressed: () => cartController.removeItem(index),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.remove, size: 20, color: isDarkMode ? Colors.orange : Colors.red),
//                                   onPressed: () {
//                                     if (quantity > 1) {
//                                       cartController.addToCart(item, -1);
//                                     } else {
//                                       cartController.removeItem(index);
//                                     }
//                                   },
//                                 ),
//                                 Obx(() => Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                       child: Text("${cartController.quantities[index]}",
//                                           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                                     )),
//                                 IconButton(
//                                   icon: Icon(Icons.add, size: 20, color: isDarkMode ? Colors.orange : Colors.green),
//                                   onPressed: () => cartController.addToCart(item, 1),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
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
//         if (cartController.items.isEmpty) return const SizedBox.shrink();

//         final subtotal = cartController.totalPrice;
//         final deliveryFee = cartController.deliveryFee.value;
//         final total = subtotal + deliveryFee;

//         return Container(
//           padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
//           decoration: BoxDecoration(
//             color: cardColor,
//             boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5, spreadRadius: 1)],
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _priceRow("Subtotal", subtotal, color: isDarkMode ? Colors.orange : Colors.black87),
//               _priceRow("Delivery Fee", deliveryFee, color: isDarkMode ? Colors.orange : Colors.black87),
//               const Divider(height: 16, color: Colors.grey),
//               _priceRow("Total", total, isBold: true, color: isDarkMode ? Colors.orange : primaryColor, fontSize: 18),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       icon: Icon(Icons.location_on_outlined, color: accentColor),
//                       label: const Text("Location"),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         side: BorderSide(color: accentColor, width: 2),
//                         backgroundColor: backgroundColor,
//                       ),
//                       onPressed: _chooseDeliveryLocation,
//                     ),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
//                       label: const Text("Checkout", style: TextStyle(color: Colors.white)),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                         elevation: 5,
//                       ),
//                       onPressed: _checkout,
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

//   Widget _priceRow(String label, double value,
//       {bool isBold = false, Color color = Colors.black87, double fontSize = 16}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: fontSize, color: color)),
//           Text("\៛${value.toStringAsFixed(2)}",
//               style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w600, fontSize: fontSize, color: color)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../app/controllers/cart_controller.dart';
import '../../app/controllers/payment_controller.dart';
import '../views/location_screen.dart';
import '../views/payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.put(CartController());
  final paymentController = Get.put(PaymentController());

  void _chooseDeliveryLocation() async {
    final result = await Get.to(() => const DeliveryLocationScreen());
    if (result != null && result is LatLng) {
      cartController.setDeliveryLocation(result);
      Get.snackbar(
        'Location Selected',
        'Delivery location updated!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );
    }
  }

  void _checkout() {
    if (cartController.deliveryLocation.value == null) {
      Get.snackbar(
        'No Location',
        'Please select delivery location!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    paymentController.setSubtotal(cartController.totalPrice);
    paymentController.deliveryFee.value = cartController.deliveryFee.value;
    paymentController.setDeliveryLocation(cartController.deliveryLocation.value!);

    Get.to(() => const PaymentScreen());
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // === Colors ===
    final primaryColor = isDarkMode ? Colors.orange :Colors.orange;
    final accentColor = isDarkMode ? Colors.orangeAccent : Colors.amber.shade600;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final backgroundColor = isDarkMode ? Colors.black87 : const Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Your Cart 🛒",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text("Your cart is empty!", style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 16, bottom: 160),
          itemCount: cartController.items.length,
          itemBuilder: (context, index) {
            final item = cartController.items[index];
            final quantity = cartController.quantities[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Card(
                color: cardColor,
                elevation: isDarkMode ? 6 : 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                shadowColor: isDarkMode ? Colors.black54 : Colors.grey.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: (item.image.isNotEmpty && item.image.startsWith('http'))
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(item.image, fit: BoxFit.cover),
                              )
                            : (item.image.isNotEmpty)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(item.image, fit: BoxFit.cover),
                                  )
                                : const Center(child: Icon(Icons.image_not_supported)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : Colors.black87)),
                            const SizedBox(height: 6),
                            Text("\$${(item.price * quantity).toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold)),
                            Text("\$${item.price.toStringAsFixed(2)} per unit",
                                style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 24, color: Colors.redAccent),
                            onPressed: () => cartController.removeItem(index),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey[800] : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove,
                                      size: 20, color: isDarkMode ? Colors.orange : Colors.red),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      cartController.addToCart(item, -1);
                                    } else {
                                      cartController.removeItem(index);
                                    }
                                  },
                                ),
                                Obx(() => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text("${cartController.quantities[index]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: isDarkMode ? Colors.white : Colors.black87)),
                                    )),
                                IconButton(
                                  icon: Icon(Icons.add, size: 20, color: isDarkMode ? Colors.orange : Colors.green),
                                  onPressed: () => cartController.addToCart(item, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        if (cartController.items.isEmpty) return const SizedBox.shrink();

        final subtotal = cartController.totalPrice;
        final deliveryFee = cartController.deliveryFee.value;
        final total = subtotal + deliveryFee;

        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          decoration: BoxDecoration(
            color: cardColor,
            boxShadow: [
              BoxShadow(
                  color: isDarkMode ? Colors.black.withOpacity(0.25) : Colors.grey.shade400,
                  blurRadius: 8,
                  spreadRadius: 1)
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _priceRow("Subtotal", subtotal, color: isDarkMode ? Colors.orange : Colors.black87),
              _priceRow("Delivery Fee", deliveryFee, color: isDarkMode ? Colors.orange : Colors.black87),
              const Divider(height: 20, color: Colors.grey),
              _priceRow("Total", total, isBold: true, color: isDarkMode ? Colors.orange : primaryColor, fontSize: 18),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.location_on_outlined, color: accentColor),
                      label: const Text("Location", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        // side: BorderSide(color: accentColor, width: 0),
                        backgroundColor: isDarkMode ? Colors.black87 : const Color(0xFF142338),

                      ),
                      onPressed: _chooseDeliveryLocation,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white, fontWeight: FontWeight.w800),
                      label: const Text("Checkout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 6,
                        shadowColor: Colors.black54,
                      ),
                      onPressed: _checkout,
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

  Widget _priceRow(String label, double value,
      {bool isBold = false, Color color = Colors.black87, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: fontSize, color: color)),
          Text("\៛${value.toStringAsFixed(2)}",
              style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w600, fontSize: fontSize, color: color)),
        ],
      ),
    );
  }
}
