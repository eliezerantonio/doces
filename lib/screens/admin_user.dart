import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:danny_doces/models/users/admin_user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Usuários"),
          centerTitle: true,
        ),
        body: Consumer<AdminUserManager>(
          builder: (_, adminUserManager, __) {
            return ListView.builder(
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(
                    adminUserManager.users[index].name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.black),
                  ),
                  subtitle: Text(
                    adminUserManager.users[index].email!,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
              itemCount: adminUserManager.names.length,
            );
          },
        ));
  }
}
