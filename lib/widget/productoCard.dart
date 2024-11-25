import 'package:flutter/material.dart';

class ProductoCard extends StatelessWidget {
  const ProductoCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        color: Colors.red,
        height: 400,
        margin: EdgeInsets.only(top: 30, bottom: 50),
      ),
    );
  }
}