import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danny_doces/utils/firebase_erros.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserProvider() {
    loadCurrentUser();
  }
  late UserModel user;
  bool _loading = false;

//login

  Future signIn({
    required UserModel user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;

    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);

      await loadCurrentUser(firebaseUser: result);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

//cadastro
  Future<void> signUp({
    required UserModel user,
    required Function onFail,
    required Function onSuccess,
  }) async {
    loading = true;
    try {
      final result = await auth.createUserWithEmailAndPassword( email: user.email!, password: user.password!);

      user.id = result.user!.uid;

      //chamando o metodo salvar
      await user.saveData();
      this.user = user;

      onSuccess();
    } catch (e) {
      onFail(getErrorString(e.toString()));
    } finally {
      loading = false;
    }
  }

  Future<void> loadCurrentUser({UserCredential? firebaseUser}) async {
    final currentUser = firebaseUser?.user! ?? auth.currentUser;

    // currentUser.sendEmailVerification();
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = UserModel.fromDocument(docUser);

      try {
        //verificando usuario admin
        final docAdmin =
            await firestore.collection('admins').doc(user.id).get();

        if (docAdmin.exists) {
          user.admin = true;
        }

        notifyListeners();
      } catch (e) {}
      notifyListeners();
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get adminEnabled => user != null && user.admin;
}
