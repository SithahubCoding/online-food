// import 'package:get/get.dart';
// import '../data/seller_request_db.dart';
// import 'user_controller.dart';
// import '../controllers/seller_request_controller.dart'; // import the model
// import '../models/sub_category_model.dart';
// class SellerRequestController extends GetxController {
//   var requests = <SellerRequest>[].obs;

//   Future<void> fetchRequests() async {
//     final list = await SellerRequestDB.getRequests();
//     requests.value = list.map((e) => SellerRequest(
//       id: e['id'],
//       userId: e['userId'],
//       shopName: e['shopName'],
//       status: e['status'],
//       submittedAt: e['submittedAt'],
//       name: e['name'],
//       email: e['email'],
//       phone: e['phone'],
//       address: e['address'],
//       card: e['card'],
//     )).toList();
//   }

//   Future<void> submitRequest({
//     required int userId,
//     required String shopName,
//     String? name,
//     String? email,
//     String? phone,
//     String? address,
//     String? card,
//   }) async {
//     await SellerRequestDB.addRequest(
//       userId: userId,
//       shopName: shopName,
//       name: name,
//       email: email,
//       phone: phone,
//       address: address,
//       card: card,
//     );
//     await fetchRequests();
//   }

//   Future<void> approveRequest(int requestId, UserController userController) async {
//     await SellerRequestDB.updateStatus(requestId, "approved");
//     await fetchRequests();
//     userController.updateRole("seller");
//   }

//   Future<void> rejectRequest(int requestId) async {
//     await SellerRequestDB.updateStatus(requestId, "rejected");
//     await fetchRequests();
//   }
// }
