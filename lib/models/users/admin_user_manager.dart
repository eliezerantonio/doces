import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danny_doces/models/users/user_provider.dart';
import 'package:flutter/foundation.dart';

import 'user_model.dart';

class AdminUserManager extends ChangeNotifier {
  List<UserModel> users = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserProvider userManager) {
    if (userManager.adminEnabled) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.docs.map((d) => UserModel.fromDocument(d)).toList();

      users.sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names {
    return users.map((e) => e.name!).toList();
  }
}
