import 'package:flutter/material.dart';

class SaleInfoScreen extends StatelessWidget {
  const SaleInfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sale Info")),
      body: const Center(child: Text("Sale Info Content")),
    );
  }
}