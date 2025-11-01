// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '../../controllers/user_controller.dart';
// import '../../controllers/seller_request_controller.dart';
// import '../../models/seller_request_model.dart';

// class RequestSellerScreen extends StatefulWidget {
//   const RequestSellerScreen({super.key});

//   @override
//   State<RequestSellerScreen> createState() => _RequestSellerScreenState();
// }

// class _RequestSellerScreenState extends State<RequestSellerScreen> {
//   final UserController userController = Get.put(UserController());
//   final SellerRequestController requestController = Get.put(SellerRequestController());
//   final ImagePicker _picker = ImagePicker();
//   File? _idCardImage;
//   final TextEditingController _shopController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     requestController.fetchRequests();
//   }

//   Future<void> _pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) setState(() => _idCardImage = File(image.path));
//   }

//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Color(0xFFFFC107);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Request Seller Account", style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: primaryColor,
//         elevation: 3,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Obx(() {
//           final role = userController.currentUser.value.role;

//           if (role == "seller") {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.verified, size: 80, color: Colors.green),
//                   SizedBox(height: 16),
//                   Text("🎉 You are now a seller!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             );
//           }

//           final request = requestController.requests.firstWhere(
//             (r) => r.userId == userController.currentUser.value.id,
//             orElse: () => SellerRequest(userId: 0, shopName: "", status: "none", submittedAt: ""),
//           );

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Store Name
//               TextField(
//                 controller: _shopController,
//                 decoration: InputDecoration(
//                   labelText: "Store Name",
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   prefixIcon: const Icon(Icons.store),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Upload ID Card
//               const Text("Upload ID Card", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               const SizedBox(height: 8),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   width: double.infinity,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade400),
//                     boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, offset: const Offset(2, 2))],
//                   ),
//                   child: _idCardImage == null
//                       ? const Icon(Icons.upload_file, size: 50, color: Colors.grey)
//                       : ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(_idCardImage!, fit: BoxFit.cover)),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Submit Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_shopController.text.isEmpty || _idCardImage == null) {
//                       Get.snackbar("Error", "Please fill store name & upload ID card", backgroundColor: Colors.red, colorText: Colors.white);
//                       return;
//                     }
//                     requestController.submitRequest(userController.currentUser.value.id, _shopController.text);
//                     Get.snackbar("Request Sent", "Your seller request has been submitted", backgroundColor: Colors.green, colorText: Colors.white);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primaryColor,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: const Text("Submit Request", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Requests List
//               const Text("Your Requests", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               const SizedBox(height: 8),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: requestController.requests.length,
//                   itemBuilder: (context, index) {
//                     final r = requestController.requests[index];
//                     return Card(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       elevation: 2,
//                       margin: const EdgeInsets.symmetric(vertical: 6),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         title: Text(r.shopName),
//                         subtitle: AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 400),
//                           child: Text(
//                             "Status: ${r.status}",
//                             key: ValueKey(r.status),
//                             style: TextStyle(
//                               color: r.status == "approved"
//                                   ? Colors.green
//                                   : r.status == "rejected"
//                                       ? Colors.red
//                                       : Colors.orange,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         trailing: role == "admin" && r.status == "pending"
//                             ? Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.check, color: Colors.green),
//                                     onPressed: () => requestController.approveRequest(r.id, userController),
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.close, color: Colors.red),
//                                     onPressed: () => requestController.rejectRequest(r.id),
//                                   ),
//                                 ],
//                               )
//                             : null,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
