import 'package:animate_do/animate_do.dart';
import 'package:danny_doces/models/users/user_provider.dart';
import 'package:danny_doces/screens/home_screen.dart';
import 'package:danny_doces/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();

    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        userProvider.loadCurrentUser().whenComplete(() {
          if (userProvider.auth.currentUser != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => LoginScreen()));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink[300]!, Colors.orange[300]!],
        ),
      ),
      child: Center(
        child: BounceInDown(
            duration: const Duration(milliseconds: 3000),
            child: Image.asset("img/LogoDD_Branco@300x.png", height: 250)),
      ),
    );
  }
}
