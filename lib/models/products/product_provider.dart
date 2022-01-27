import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late StreamSubscription _subscription;
  List<Product> allProducts = [];

  // Para carregar todos o produtos do firebase
  Future<void> _loadAllProducts() async {
    _subscription =
        firestore.collection('products').snapshots().listen((event) {
      allProducts.clear();

      for (final doc in event.docs) {
        allProducts.add(Product.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  void update(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
