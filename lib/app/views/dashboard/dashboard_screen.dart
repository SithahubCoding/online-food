import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'add_product_screen.dart';
import 'payment_info_screen.dart';
import 'sale_info_screen.dart';
import 'product_list_screen.dart';
import 'notification_screen.dart';
import '../home/home_screen.dart';
// import '../dashboard/admin_request_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // 🔹 Helper to get sales count per month
  Stream<List<double>> salesPerMonth() {
    return FirebaseFirestore.instance.collection('sales').snapshots().map((
      snapshot,
    ) {
      // Initialize a list for 12 months with 0.0 sales
      List<double> monthly = List.generate(12, (index) => 0.0);
      for (var doc in snapshot.docs) {
        Timestamp ts = doc['createdAt'];
        // month is 1-based, array is 0-based
        int month = ts.toDate().month - 1; 
        double amount = doc['total'].toDouble();
        monthly[month] += amount;
      }
      return monthly;
    });
  }

  // 🔹 Helper to get product category distribution
  Stream<Map<String, double>> productCategoryData() {
    return FirebaseFirestore.instance.collection('product_db').snapshots().map((
      snapshot,
    ) {
      Map<String, double> data = {};
      for (var doc in snapshot.docs) {
        String cat = doc['category'] ?? 'Others';
        data[cat] = (data[cat] ?? 0) + 1;
      }
      return data;
    });
  }
  
  // 🔹 Constant list for all month titles
  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard Overview",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationScreen()),
              );
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                "Admin Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Add Product"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddDataScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits),
              title: const Text("Products"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProductScreenList()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text("Payment Info"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PaymentInfoScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Sale Info"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SaleInfoScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Notification"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SaleInfoScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sell), 
              title: const Text("AddDataScreen"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddDataScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_2), 
              title: const Text("User View"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.back_hand), 
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ស្ថិតិការលក់ និងទំនិញ", // Sales and Inventory Statistics
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 🔹 Bar Chart (Sales per Month)
            StreamBuilder<List<double>>(
              stream: salesPerMonth(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<double> sales = snapshot.data!;
                // Ensure sales list is exactly 12 elements for titles to align
                if (sales.length > 12) sales = sales.sublist(0, 12);
                
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: sales.reduce((a, b) => a > b ? a : b) * 1.1, // Dynamic MaxY
                          titlesData: FlTitlesData(
                            show: true,
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                // Use max 6 labels if data is sparse to keep it clean
                                interval: sales.length > 6 ? 2.0 : 1.0, 
                                getTitlesWidget: (value, meta) {
                                  final monthIndex = value.toInt();
                                  if (monthIndex >= 0 && monthIndex < _months.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        _months[monthIndex],
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 200, // Example interval
                          ),
                          barGroups: List.generate(
                            sales.length,
                            (i) => BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  toY: sales[i],
                                  color: Colors.blueAccent,
                                  width: 10,
                                  borderRadius: BorderRadius.circular(4),
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

            const SizedBox(height: 30),

            // 🔹 Pie Chart (Product Category)
            const Text(
              "សមាមាត្រទំនិញតាមប្រភេទ", // Product proportion by category
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            StreamBuilder<Map<String, double>>(
              stream: productCategoryData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                   return const Center(child: CircularProgressIndicator());
                }
                Map<String, double> data = snapshot.data!;
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 250,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: PieChart(
                              PieChartData(
                                sectionsSpace: 2,
                                centerSpaceRadius: 40,
                                sections: data.entries
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) {
                                      final index = entry.key;
                                      final e = entry.value;
                                      final color = Colors.primaries[index % Colors.primaries.length];
                                      
                                      return PieChartSectionData(
                                        color: color,
                                        value: e.value,
                                        title: "${e.value.toInt()}",
                                        radius: 60,
                                        titleStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        badgeWidget: Text(e.key.length > 8 ? '${e.key.substring(0, 7)}...' : e.key,
                                          style: TextStyle(color: color, fontWeight: FontWeight.bold)
                                        ),
                                        badgePositionPercentageOffset: 1.0,
                                      );
                                    },
                                  ).toList(),
                              ),
                            ),
                          ),
                          
                          // Legend
                          Expanded(
                            flex: 2,
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              children: data.entries.toList().asMap().entries.map((entry) {
                                final index = entry.key;
                                final e = entry.value;
                                final color = Colors.primaries[index % Colors.primaries.length];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: color,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          "${e.key} (${e.value.toInt()})",
                                          style: const TextStyle(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // 🔹 Line Chart (Payment / Sale Growth)
            const Text(
              "ស្ថិតិការទូទាត់ និងចំណូល", // Payment and Revenue Statistics
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            StreamBuilder<List<double>>(
              stream: salesPerMonth(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                   return const Center(child: CircularProgressIndicator());
                }
                List<double> sales = snapshot.data!;
                if (sales.length > 12) sales = sales.sublist(0, 12);
                
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true, drawVerticalLine: false),
                          borderData: FlBorderData(show: false),
                          maxY: sales.reduce((a, b) => a > b ? a : b) * 1.1,
                          titlesData: FlTitlesData(
                            show: true,
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: sales.length > 6 ? 2.0 : 1.0,
                                getTitlesWidget: (value, meta) {
                                  final monthIndex = value.toInt();
                                  if (monthIndex >= 0 && monthIndex < _months.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        _months[monthIndex],
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              color: Colors.green,
                              barWidth: 3,
                              spots: List.generate(
                                sales.length,
                                (i) => FlSpot(i.toDouble(), sales[i]),
                              ),
                              dotData: const FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.green,
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'add_product_screen.dart';
// import 'payment_info_screen.dart';
// import 'sale_info_screen.dart';
// import 'product_list_screen.dart';
// import 'notification_screen.dart';
// import '../home/home_screen.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   // 🔹 Get sales per month from Firestore
//   Stream<List<double>> salesPerMonth() {
//     return FirebaseFirestore.instance.collection('sales').snapshots().map((snapshot) {
//       List<double> monthly = List.generate(12, (index) => 0.0);
//       for (var doc in snapshot.docs) {
//         Timestamp ts = doc['createdAt'];
//         int month = ts.toDate().month - 1;
//         double amount = (doc['total'] ?? 0).toDouble();
//         monthly[month] += amount;
//       }
//       return monthly;
//     });
//   }

//   // 🔹 Get product category count
//   Stream<Map<String, double>> productCategoryData() {
//     return FirebaseFirestore.instance.collection('product_db').snapshots().map((snapshot) {
//       Map<String, double> data = {};
//       for (var doc in snapshot.docs) {
//         String cat = doc['category'] ?? 'Others';
//         data[cat] = (data[cat] ?? 0) + 1;
//       }

//       // Group small categories into "Others"
//       Map<String, double> groupedData = {};
//       double othersCount = 0;
//       data.forEach((key, value) {
//         if (value < 3) {
//           othersCount += value;
//         } else {
//           groupedData[key] = value;
//         }
//       });
//       if (othersCount > 0) groupedData['Others'] = othersCount;

//       return groupedData;
//     });
//   }

//   static const List<String> _months = [
//     'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//     'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Dashboard Overview",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const NotificationScreen()),
//               );
//             },
//             icon: const Icon(Icons.notifications, color: Colors.white),
//           ),
//         ],
//       ),
//       drawer: _buildDrawer(context),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "ស្ថិតិការលក់ និងទំនិញ",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             _buildSalesBarChart(),
//             const SizedBox(height: 30),
//             const Text(
//               "សមាមាត្រទំនិញតាមប្រភេទ",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             _buildCategoryPieChart(),
//             const SizedBox(height: 30),
//             const Text(
//               "ស្ថិតិការទូទាត់ និងចំណូល",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             _buildSalesLineChart(),
//           ],
//         ),
//       ),
//     );
//   }

//   Drawer _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(color: Colors.orange),
//             child: Text(
//               "Admin Menu",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.add),
//             title: const Text("Add Product"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const AddDataScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.production_quantity_limits),
//             title: const Text("Products"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const ProductScreenList()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.payment),
//             title: const Text("Payment Info"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const PaymentInfoScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.bar_chart),
//             title: const Text("Sale Info"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const SaleInfoScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.person_2),
//             title: const Text("User View"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const HomeScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text("Logout"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const HomeScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSalesBarChart() {
//     return StreamBuilder<List<double>>(
//       stream: salesPerMonth(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         List<double> sales = snapshot.data!;
//         if (sales.length > 12) sales = sales.sublist(0, 12);
//         double maxY = sales.reduce((a, b) => a > b ? a : b) * 1.1;

//         return Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: SizedBox(
//               height: 200,
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceAround,
//                   maxY: maxY,
//                   titlesData: FlTitlesData(
//                     show: true,
//                     topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         interval: 1.0,
//                         getTitlesWidget: (value, meta) {
//                           int index = value.toInt();
//                           if (index >= 0 && index < _months.length) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(_months[index], style: const TextStyle(fontSize: 10)),
//                             );
//                           }
//                           return Container();
//                         },
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: (value, meta) => Text("\$${value.toInt()}"),
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   gridData: const FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 200),
//                   barGroups: List.generate(
//                     sales.length,
//                     (i) => BarChartGroupData(
//                       x: i,
//                       barRods: [
//                         BarChartRodData(toY: sales[i], color: Colors.blueAccent, width: 10, borderRadius: BorderRadius.circular(4)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSalesLineChart() {
//     return StreamBuilder<List<double>>(
//       stream: salesPerMonth(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         List<double> sales = snapshot.data!;
//         if (sales.length > 12) sales = sales.sublist(0, 12);
//         double maxY = sales.reduce((a, b) => a > b ? a : b) * 1.1;

//         return Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: SizedBox(
//               height: 200,
//               child: LineChart(
//                 LineChartData(
//                   gridData: const FlGridData(show: true, drawVerticalLine: false),
//                   borderData: FlBorderData(show: false),
//                   maxY: maxY,
//                   titlesData: FlTitlesData(
//                     show: true,
//                     topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         interval: 1.0,
//                         getTitlesWidget: (value, meta) {
//                           int index = value.toInt();
//                           if (index >= 0 && index < _months.length) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(_months[index], style: const TextStyle(fontSize: 10)),
//                             );
//                           }
//                           return Container();
//                         },
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: (value, meta) => Text("\$${value.toInt()}"),
//                       ),
//                     ),
//                   ),
//                   lineBarsData: [
//                     LineChartBarData(
//                       isCurved: true,
//                       color: Colors.green,
//                       barWidth: 3,
//                       spots: List.generate(sales.length, (i) => FlSpot(i.toDouble(), sales[i])),
//                       dotData: const FlDotData(show: true),
//                       belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.3)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCategoryPieChart() {
//     return StreamBuilder<Map<String, double>>(
//       stream: productCategoryData(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         Map<String, double> data = snapshot.data!;
//         return Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 250,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: PieChart(
//                       PieChartData(
//                         sectionsSpace: 2,
//                         centerSpaceRadius: 40,
//                         sections: data.entries.toList().asMap().entries.map((entry) {
//                           final index = entry.key;
//                           final e = entry.value;
//                           final color = Colors.primaries[index % Colors.primaries.length];
//                           return PieChartSectionData(
//                             color: color,
//                             value: e.value,
//                             title: "${e.value.toInt()}",
//                             radius: 60,
//                             titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
//                             badgeWidget: Text(
//                               e.key.length > 8 ? '${e.key.substring(0, 7)}...' : e.key,
//                               style: TextStyle(color: color, fontWeight: FontWeight.bold),
//                             ),
//                             badgePositionPercentageOffset: 1.0,
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: ListView(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       children: data.entries.toList().asMap().entries.map((entry) {
//                         final index = entry.key;
//                         final e = entry.value;
//                         final color = Colors.primaries[index % Colors.primaries.length];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4.0),
//                           child: Row(
//                             children: [
//                               Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
//                               const SizedBox(width: 8),
//                               Flexible(child: Text("${e.key} (${e.value.toInt()})", style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
