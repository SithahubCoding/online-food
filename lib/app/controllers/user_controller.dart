import 'package:get/get.dart';
import '../data/database_helper.dart';

class UserModel {
  int id;
  String name;
  String email;
  String role; // user, seller, admin
  UserModel({required this.id, required this.name, required this.email, required this.role});
}

class UserController extends GetxController {
  var currentUser = UserModel(id: 1, name: "John Doe", email: "john@example.com", role: "user").obs;

  Future<void> updateRole(String newRole) async {
    currentUser.update((user) { if(user != null) user.role = newRole; });
    final db = await DatabaseHelper.instance.database;
    await db.update('users', {'role': newRole}, where: 'id = ?', whereArgs: [currentUser.value.id]);
  }
}

