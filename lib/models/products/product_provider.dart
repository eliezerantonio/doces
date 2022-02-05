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
  List<String> categories = ["Bolo", "Salgados"];

  // Para carregar todos o produtos do firebase
  Future<void> _loadAllProducts() async {
    _subscription =
        firestore.collection('products2').snapshots().listen((event) {
      allProducts.clear();

      for (final doc in event.docs) {
        allProducts.add(Product.fromDocument(doc));
      }
      notifyListeners();
    });
  }

  Future<void> loadAllCategory(String category) async {
    print(category);
    _subscription = firestore
        .collection('products2')
        .where('category', isEqualTo: category.toLowerCase())
        .snapshots()
        .listen((event) {
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

  //pesquisa
  String _search = '';
  String _category = '';

  String get search => _search;
  String get category => _category;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts
            .where((p) => p.name!.toLowerCase().contains(search.toLowerCase())),
      );
    }
    return filteredProducts;
  }
}
