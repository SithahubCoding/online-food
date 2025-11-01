import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class SellerRequestDB {
  // Add new request
  static Future<int> addRequest({
    required int userId,
    required String shopName,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? card,
  }) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('seller_requests', {
      'userId': userId,
      'shopName': shopName,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'card': card,
      'status': 'pending',
      'submittedAt': DateTime.now().toIso8601String(),
    });
  }

  // Get all requests
  static Future<List<Map<String, dynamic>>> getRequests() async {
    final db = await DatabaseHelper.instance.database;
    return await db.query('seller_requests', orderBy: 'id DESC');
  }

  // Update status
  static Future<int> updateStatus(int id, String status) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'seller_requests',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get request by user
  static Future<Map<String, dynamic>?> getRequestByUser(int userId) async {
    final db = await DatabaseHelper.instance.database;
    final res = await db.query(
      'seller_requests',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return res.isNotEmpty ? res.first : null;
  }
}
