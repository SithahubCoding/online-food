import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'add_product_screen.dart';
import 'payment_info_screen.dart';
import 'sale_info_screen.dart';
import 'product_list_screen.dart';
import 'notification_screen.dart';
import '../home/home_screen.dart';
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // 🔹 Helper to get sales count per month
  Stream<List<double>> salesPerMonth() {
    return FirebaseFirestore.instance.collection('sales').snapshots().map((
      snapshot,
    ) {
      List<double> monthly = List.generate(12, (index) => 0.0);
      for (var doc in snapshot.docs) {
        Timestamp ts = doc['createdAt'];
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
              leading: const Icon(Icons.back_hand), 
              title: const Text("Back"),
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
              "ស្ថិតិការលក់ និងទំនិញ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // 🔹 Bar Chart (Sales per Month)
            StreamBuilder<List<double>>(
              stream: salesPerMonth(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                List<double> sales = snapshot.data!;
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
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    'Jan',
                                    'Feb',
                                    'Mar',
                                    'Apr',
                                    'May',
                                    'Jun',
                                  ];
                                  return Text(
                                    months[value.toInt() % months.length],
                                  );
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: List.generate(
                            sales.length,
                            (i) => BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  toY: sales[i],
                                  color: Colors.blueAccent,
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
              "សមាមាត្រទំនិញតាមប្រភេទ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            StreamBuilder<Map<String, double>>(
              stream: productCategoryData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                Map<String, double> data = snapshot.data!;
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SizedBox(
                    height: 220,
                    child: PieChart(
                      PieChartData(
                        sections: data.entries
                            .map(
                              (e) => PieChartSectionData(
                                color:
                                    Colors.primaries[data.keys.toList().indexOf(
                                          e.key,
                                        ) %
                                        Colors.primaries.length],
                                value: e.value,
                                title: "${e.key}\n${e.value.toInt()}",
                                radius: 60,
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // 🔹 Line Chart (Payment / Sale Growth)
            const Text(
              "ស្ថិតិការទូទាត់ និងចំណូល",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            StreamBuilder<List<double>>(
              stream: salesPerMonth(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                List<double> sales = snapshot.data!;
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
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    'Jan',
                                    'Feb',
                                    'Mar',
                                    'Apr',
                                    'May',
                                    'Jun',
                                  ];
                                  return Text(
                                    months[value.toInt() % months.length],
                                  );
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
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
