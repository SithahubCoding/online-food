// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/seller_request_controller.dart';
// import '../../controllers/user_controller.dart';

// class AdminRequestScreen extends StatelessWidget {
//   final SellerRequestController requestController = Get.find();
//   final UserController userController = Get.find();

//   AdminRequestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Admin: Seller Requests")),
//       body: Obx(() {
//         final requests = requestController.requests;
//         if (requests.isEmpty) {
//           return const Center(child: Text("No requests found."));
//         }
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: requests.length,
//           itemBuilder: (context, index) {
//             final r = requests[index];
//             Color statusColor;
//             switch (r.status) {
//               case "approved":
//                 statusColor = Colors.green;
//                 break;
//               case "rejected":
//                 statusColor = Colors.red;
//                 break;
//               default:
//                 statusColor = Colors.orange;
//             }

//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 400),
//               margin: const EdgeInsets.symmetric(vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, offset: const Offset(2,2))],
//               ),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 title: Text("User ID: ${r.userId}"),
//                 subtitle: Row(
//                   children: [
//                     Expanded(child: Text("Shop: ${r.shopName}")),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: statusColor.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         r.status.toUpperCase(),
//                         style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//                 trailing: r.status == "pending"
//                     ? Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.check, color: Colors.green),
//                             onPressed: () => requestController.approveRequest(r.id, userController),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.close, color: Colors.red),
//                             onPressed: () => requestController.rejectRequest(r.id),
//                           ),
//                         ],
//                       )
//                     : null,
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
