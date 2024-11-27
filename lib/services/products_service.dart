import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crud_rest_camara/models/product.dart';
import 'package:flutter/material.dart';

class ProductsService extends ChangeNotifier{
  final String _baseUrl = 'flutter-varios-58a64-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Product> products = [];
  bool isLoading = true;


  ProductsService(){
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = jsonDecode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;
  }
}
