import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/profile_controller.dart';
import '../controllers/auth_controller.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'auth/login_screen.dart';
import 'favorite_screen.dart';
import 'cart_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final profileController = Get.put(ProfileController());
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              // Header with user info
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.deepOrangeAccent],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profileController.displayName.value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      profileController.email.value,
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Profile Options
              _buildTile(
                icon: Icons.edit,
                text: "Edit Profile",
                onTap: () => Get.to(() => EditProfileScreen()),
              ),
              _buildTile(
                icon: Icons.lock,
                text: "Change Password",
                onTap: () => Get.to(() => ChangePasswordScreen()),
              ),
              _buildTile(
                icon: Icons.shopping_bag,
                text: "My Cart",
                onTap: () => Get.to(() => CartScreen()),
              ),
              _buildTile(
                icon: Icons.favorite,
                text: "Favorites",
                onTap: () => Get.to(() => FavoriteScreen()),
              ),
              _buildTile(
                icon: Icons.settings,
                text: "Settings",
                onTap: () {},
              ),
              _buildTile(
                icon: Icons.exit_to_app,
                text: "Logout",
                onTap: () {
                  Get.defaultDialog(
                    title: "Confirm Logout",
                    middleText: "Do you really want to log out?",
                    textCancel: "No",
                    textConfirm: "Yes",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.deepOrange,
                    onConfirm: () {
                      authController.signOut();
                      Get.offAll(() => LoginScreen());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable ListTile Builder
  Widget _buildTile({required IconData icon, required String text, VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
