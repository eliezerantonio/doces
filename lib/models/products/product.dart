import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Product with ChangeNotifier {
  String? id;
  String? name;
  String? description;
  String? category;
  dynamic? image;
  num? price;

  Product({
    this.id,
    this.name,
    this.image,
    this.category,
    this.description,
    this.price,
  });

  Product.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    id = document.id;
    name = data['name'] as String;
    image = data['image'] as String;
    category = data['category'] as String;
    price = data['price'] as num;
    description = data['description'] as String;
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection("products2").doc(id);
  firebase_storage.Reference get storageRef =>
      firebase_storage.FirebaseStorage.instance.ref("products2");

  Future<void> save({
    required dynamic imageFile,
    required Function onSuccess,
    required Function onFail,
  }) async {
    loading = true;

    try {
      firebase_storage.UploadTask task =
          storageRef.child(const Uuid().v1()).putFile(imageFile);

      final snapshot = await task;
      final String url = await snapshot.ref.getDownloadURL();
      image = url;
      final Map<String, dynamic> data = {
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'image': image ?? ''
      };

      // Criar se for nulo ou atualizar se ja existir na base de dados
      if (id == null) {
        final doc = await firestoreRef.set(data);
      } else {
        await firestoreRef.update(data);
      }
      onSuccess();
    } catch (e) {
      print(e);
      onFail();
    } finally {
      loading = false;
    }
  }

  Future<File> uploadPhoto() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return File(pickedFile!.path);
  }

  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      category: category,
      image: image,
    );
  }

  void delete() {
    firestoreRef.delete();
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'category: $category';
  }
}
