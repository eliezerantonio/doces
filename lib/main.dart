import 'package:danny_doces/models/products/product.dart';
import 'package:danny_doces/screens/register_screen.dart';
import 'package:danny_doces/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'models/products/product_provider.dart';
import 'models/users/user_provider.dart';
import 'screens/edit_product_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Product(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProductProvider(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(
            primaryColor: Colors.pink[200],
            primaryIconTheme: Theme.of(context)
                .primaryIconTheme
                .copyWith(color: Colors.black)),
        home:  const SplashScreen(),
      ),
    );
  }
}
