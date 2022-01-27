import 'package:animate_do/animate_do.dart';
import 'package:danny_doces/models/users/user_model.dart';
import 'package:danny_doces/models/users/user_provider.dart';

import 'package:danny_doces/screens/home_screen.dart';
import 'package:danny_doces/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final UserModel user = UserModel();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          background(size),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.3,
                  left: size.width * 0.03,
                  right: size.width * 0.03),
              height: 470,
              width: size.width,
              child: Card(
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey[600]),
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                              onSaved: (email) => user.email = email!,
                              keyboardType: TextInputType.emailAddress,
                              validator: (email) {
                                if (email!.trim().isEmpty ||
                                    !email.contains("@")) {
                                  return 'Email deve ser preenchidos';
                                }
                                return null;
                              },
                              labelText: "Enter Email",
                              iconData: Icons.email),
                          SizedBox(height: 25),
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
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Checkbox(
                                onChanged: (bool? value) {},
                                value: false,
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(),
                              Text("Forgot Password",
                                  style: TextStyle(
                                    color: Colors.pink[600],
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                          CustomButton(
                            text: "SIGN UP",
                            enabled: userProvider.loading,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                userProvider.signIn(
                                  user: user,
                                  onSuccess: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const HomeScreen()));
                                  },
                                  onFail: (e) {
                                    print(
                                        "---------------falhou---------------------");
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
                                  child: FadeInUp(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.pink[300]!),
                                    ),
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                //Definimos a routa
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // ignore: prefer_const_constructors
                                Text(
                                  "Still not connected?  ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  " Sign Up",
                                  style: TextStyle(
                                    color: Colors.pink[600],
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 1,
                                  width: 50,
                                  alignment: Alignment.center,
                                  color: Colors.black),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.center,
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.purple),
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text("OR",
                                    style: TextStyle(color: Colors.grey)),
                              ),
                              Container(
                                  height: 1,
                                  width: 50,
                                  alignment: Alignment.center,
                                  color: Colors.black),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                  child: Image.asset(
                                "img/IMG-20211013-WA0011.jpg",
                                fit: BoxFit
                                    .cover, // permite escolher a resoluçãio da imagem
                                height: 70,
                                width: 70,
                              )),
                              ClipOval(
                                child: Image.asset(
                                  "img/IMG-20211013-WA0012.jpg",
                                  fit: BoxFit
                                      .cover, // permite escolher a resoluçãio da imagem
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container background(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink[300]!, Colors.orange[300]!],
        ),
      ),
      child:
          Center(child: Image.asset("img/LogoDD_Branco@300x.png", height: 250)),
    );
  }
}
