import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var displayName = ''.obs;
  var email = ''.obs;
  var photoUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final user = auth.currentUser;
    if (user != null) {
      displayName.value = user.displayName ?? "No name";
      email.value = user.email ?? "";
      photoUrl.value = user.photoURL ?? "";
    }
  }

  Future<void> updateProfile(String name) async {
    try {
      await auth.currentUser!.updateDisplayName(name);
      await auth.currentUser!.reload();
      loadUserData();
      Get.snackbar("Success", "Profile updated successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await auth.currentUser!.updatePassword(newPassword);
      Get.snackbar("Success", "Password updated successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
