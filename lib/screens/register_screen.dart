// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';

import 'package:danny_doces/models/users/user_model.dart';
import 'package:danny_doces/models/users/user_provider.dart';
import 'package:danny_doces/widgets/custom_button.dart';
import 'package:danny_doces/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserModel user = UserModel();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Center(
                    child: Text(
                      "Cadastro",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.pink[300]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                        "Efectue o seu cadastro para poder criar uma conta na nossa Pastelaria Virtual",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    " User Name",
                    style: TextStyle(
                        color: Colors.pink[300],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    onSaved: (name) => user.name = name!,
                    labelText: "Enter User Name",
                    iconData: Icons.person,
                    validator: (name) {
                      if (name!.trim().isEmpty) {
                        return 'Nome deve ser preenchidos';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "  Email Id",
                    style: TextStyle(
                        color: Colors.pink[300],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                      onSaved: (email) => user.email = email!,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.trim().isEmpty || !email.contains("@")) {
                          return 'Email deve ser preenchidos';
                        }
                        return null;
                      },
                      labelText: "Enter Email",
                      iconData: Icons.email),
                  const SizedBox(height: 15),
                  Text(
                    "  Mobile Number",
                    style: TextStyle(
                        color: Colors.pink[300],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                      keyboardType: TextInputType.phone,
                      validator: (phone) {
                        if (phone!.trim().isEmpty) {
                          return 'Telefone deve ser preenchidos';
                        }
                        return null;
                      },
                      onSaved: (phone) => user.phone = phone!,
                      labelText: "Enter you 10 digit mobile number",
                      iconData: Icons.phone_iphone),
                  const SizedBox(height: 15),
                  Text(
                    "  Password",
                    style: TextStyle(
                        color: Colors.pink[300],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                      validator: (password) {
                        if (password!.trim().isEmpty) {
                          return 'A senha deve ser preenchida';
                        }
                        return null;
                      },
                      onSaved: (password) => user.password = password!,
                      obscureText: true,
                      labelText: "Password should be in 8-15 chaters",
                      iconData: Icons.lock),
                  const SizedBox(height: 15),
                  Text(
                    "  Confirm Password",
                    style: TextStyle(
                        color: Colors.pink[300],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                      validator: (confirmPassword) {
                        if (confirmPassword!.trim().isEmpty) {
                          return 'A senha deve ser preenchida';
                        } else if (user.confirmPassword != user.password) {
                          return 'A Senha n confere';
                        }
                        return null;
                      },
                      obscureText: true,
                      onSaved: (confirmPassword) =>
                          user.confirmPassword = confirmPassword,
                      labelText: "Repeat the password",
                      iconData: Icons.lock),
                  const SizedBox(height: 15),
                  CustomButton(
                    text: "SIGN UP",
                    enabled: userProvider.loading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        userProvider.signUp(
                          user: user,
                          onSuccess: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sucesso!'),
                                backgroundColor: Colors.pink[300],
                              ),
                            );
                            Navigator.pop(context);
                          },
                          onFail: (e) {
                            print("---------------falhou---------------------");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Falha ao cadastrar! $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 7),
                  userProvider.loading
                      ? Center(
                          child: FadeIn(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.pink[300]!),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
