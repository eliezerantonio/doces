import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? password;
  String? confirmPassword;

  UserModel({this.email, this.phone, this.password, this.confirmPassword});

  UserModel.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    id = document.id;
    name = data['name'] as String;
    email = data['email'] as String;
    phone = data['phone'] as String;
  }

  bool admin = false;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('users').doc(id);
  DocumentReference get firestoreRefAdmin =>
      FirebaseFirestore.instance.collection('admins').doc(id);

  Future<void> saveAdmin() async {
    await firestoreRefAdmin.set({"user": id});
  }

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
