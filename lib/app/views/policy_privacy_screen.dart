// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PolicyPrivacyScreen extends StatelessWidget {
//   const PolicyPrivacyScreen({super.key});

//   final List<Map<String, dynamic>> policySections = const [
//     {
//       "title": "User",
//       "icon": Icons.person,
//       "color": Colors.blue,
//       "content": [
//         "Browse products and categories.",
//         "Create orders and add items to cart.",
//         "Mark products as favorites.",
//         "Maintain account confidentiality.",
//         "Update personal information (name, email, phone, delivery address).",
//         "Cannot access seller or admin sensitive data."
//       ],
//     },
//     {
//       "title": "Seller",
//       "icon": Icons.storefront,
//       "color": Colors.orange,
//       "content": [
//         "Create and manage products.",
//         "Manage stock, pricing, and product descriptions.",
//         "View orders related to their products only.",
//         "Ensure product data is accurate and compliant with laws.",
//         "Cannot access full user data unrelated to their products.",
//         "Cannot perform admin-only actions."
//       ],
//     },
//     {
//       "title": "Admin",
//       "icon": Icons.admin_panel_settings,
//       "color": Colors.red,
//       "content": [
//         "Full access to all users and sellers.",
//         "Add, update, or remove products.",
//         "View, update, or delete orders.",
//         "Manage users and seller accounts.",
//         "Update app settings, categories, and configurations.",
//         "Responsible for protecting user and seller data."
//       ],
//     },
//     {
//       "title": "Data Collection",
//       "icon": Icons.data_saver_on,
//       "color": Colors.green,
//       "content": [
//         "Personal Info: Name, email, phone, address (User).",
//         "Product Info: Name, category, price, description, images (Seller/Admin).",
//         "Order Info: Items, quantity, delivery address, payment info.",
//         "Usage Data: App usage, session logs, clicks, crash reports."
//       ],
//     },
//     {
//       "title": "Data Usage & Security",
//       "icon": Icons.security,
//       "color": Colors.purple,
//       "content": [
//         "Provide, improve, and personalize app experience.",
//         "Process orders and payments.",
//         "Communicate notifications, promotions, and order status.",
//         "Analyze trends and usage to improve app performance.",
//         "Encryption (HTTPS/SSL) for all data transmissions.",
//         "Sensitive data stored securely in our database."
//       ],
//     },
//     {
//       "title": "User Rights",
//       "icon": Icons.verified_user,
//       "color": Colors.teal,
//       "content": [
//         "Access and update personal info.",
//         "Delete account (data removed except necessary legal records).",
//         "Opt out of promotional communications."
//       ],
//     },
//     {
//       "title": "Policy Updates & Contact",
//       "icon": Icons.update,
//       "color": Colors.brown,
//       "content": [
//         "Policy may be updated; notifications will be sent via the app.",
//         "Contact: support@onlinefoodapp.com, +855 1234 5678"
//       ],
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios)),
//         title: const Text("Privacy Policy", style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.deepPurple,
//         elevation: 0,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: policySections.length,
//         itemBuilder: (context, index) {
//           final section = policySections[index];
//           return Card(
//             elevation: 3,
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             child: ExpansionTile(
//               leading: CircleAvatar(
//                 backgroundColor: section['color'].withOpacity(0.2),
//                 child: Icon(section['icon'], color: section['color']),
//               ),
//               title: Text(section['title'],
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: section['color'])),
//               children: List.generate(
//                 section['content'].length,
//                 (i) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("• ", style: TextStyle(fontSize: 16)),
//                       Expanded(child: Text(section['content'][i], style: const TextStyle(fontSize: 14))),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyPrivacyScreen extends StatelessWidget {
  const PolicyPrivacyScreen({super.key});

  final List<Map<String, dynamic>> policySections = const [
    {
      "title": "User",
      "icon": Icons.person,
      "color": Colors.blue,
      "content": [
        "Browse products and categories.",
        "Create orders and add items to cart.",
        "Mark products as favorites.",
        "Maintain account confidentiality.",
        "Update personal information (name, email, phone, delivery address).",
        "Cannot access seller or admin sensitive data."
      ],
    },
    {
      "title": "Seller",
      "icon": Icons.storefront,
      "color": Colors.orange,
      "content": [
        "Create and manage products.",
        "Manage stock, pricing, and product descriptions.",
        "View orders related to their products only.",
        "Ensure product data is accurate and compliant with laws.",
        "Cannot access full user data unrelated to their products.",
        "Cannot perform admin-only actions."
      ],
    },
    {
      "title": "Admin",
      "icon": Icons.admin_panel_settings,
      "color": Colors.red,
      "content": [
        "Full access to all users and sellers.",
        "Add, update, or remove products.",
        "View, update, or delete orders.",
        "Manage users and seller accounts.",
        "Update app settings, categories, and configurations.",
        "Responsible for protecting user and seller data."
      ],
    },
    {
      "title": "Data Collection",
      "icon": Icons.data_saver_on,
      "color": Colors.green,
      "content": [
        "Personal Info: Name, email, phone, address (User).",
        "Product Info: Name, category, price, description, images (Seller/Admin).",
        "Order Info: Items, quantity, delivery address, payment info.",
        "Usage Data: App usage, session logs, clicks, crash reports."
      ],
    },
    {
      "title": "Data Usage & Security",
      "icon": Icons.security,
      "color": Colors.purple,
      "content": [
        "Provide, improve, and personalize app experience.",
        "Process orders and payments.",
        "Communicate notifications, promotions, and order status.",
        "Analyze trends and usage to improve app performance.",
        "Encryption (HTTPS/SSL) for all data transmissions.",
        "Sensitive data stored securely in our database."
      ],
    },
    {
      "title": "User Rights",
      "icon": Icons.verified_user,
      "color": Colors.teal,
      "content": [
        "Access and update personal info.",
        "Delete account (data removed except necessary legal records).",
        "Opt out of promotional communications."
      ],
    },
    {
      "title": "Policy Updates & Contact",
      "icon": Icons.update,
      "color": Colors.brown,
      "content": [
        "Policy may be updated; notifications will be sent via the app.",
        "Contact: support@onlinefoodapp.com, +855 1234 5678"
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
    final appBarColor = isDarkMode ? Colors.black : Colors.white;
    final appBarTextColor = isDarkMode ? Colors.orange : Colors.black;
    final cardColor = isDarkMode ? Colors.grey[850] : Colors.white;
    final textColor = isDarkMode ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: appBarTextColor),
        ),
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: appBarTextColor,
          ),
        ),
        elevation: 0,
        backgroundColor: appBarColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: policySections.length,
        itemBuilder: (context, index) {
          final section = policySections[index];
          final sectionColor = isDarkMode ? Colors.orange : section['color'];

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              color: cardColor,
              elevation: isDarkMode ? 4 : 6,
              shadowColor: sectionColor.withOpacity(0.25),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: sectionColor.withOpacity(0.15),
                    child: Icon(section['icon'], color: sectionColor),
                  ),
                  title: Text(
                    section['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: sectionColor,
                    ),
                  ),
                  children: List.generate(
                    section['content'].length,
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 6, color: sectionColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              section['content'][i],
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
