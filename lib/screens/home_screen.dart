import 'package:danny_doces/models/products/product_provider.dart';
import 'package:danny_doces/models/users/user_provider.dart';
import 'package:danny_doces/screens/product_details_screen.dart';
import 'package:danny_doces/widgets/logo_widget.dart';
import 'package:danny_doces/widgets/promo_cake.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_user.dart';
import 'edit_product_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProviver = context.watch<UserProvider>();
    final products = context.watch<ProductProvider>();
    final list = products.filteredProducts;
    return DefaultTabController(
      length: products.categories.length,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      "Olá, ${userProviver.user.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.pink[300],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.notifications,
                      color: Colors.pink[300],
                    ),
                    if (userProviver.adminEnabled) ...[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditProductScreen()));
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.pink[300],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminUserScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.person,
                          color: Colors.pink[300],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          userProviver.logout();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.pink[300],
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text("O que você deseja?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.grey)),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pink[200],
                            borderRadius: BorderRadius.circular(30)),
                        height: 45,
                        width: double.infinity,
                        child: TextField(
                          onChanged: (text) {
                            products.search = text;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Procure aqui...",
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const LogoWidget(),
                  ],
                ),
                const SizedBox(height: 10),
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  isScrollable: true,
                  tabs: products.categories.map((e) => Text(e)).toList(),
                  onTap: (index) {
                    products.loadAllCategory(products.categories[index].toLowerCase());
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children:
                        list.map((product) => PromoCake(product)).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   "Sobremesas",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 19,
                //     color: Colors.brown[600],
                //   ),
                // ),
                // const SizedBox(
                //   height: 19,
                // ),
                // Expanded(
                //   flex: 2,
                //   child: ListView(
                //     physics: BouncingScrollPhysics(),
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       dessert("img/sobremesas-png-.png", Colors.pink[300]!),
                //       dessert("img/sobremesas-png-4.png", Colors.orange[400]!),
                //       dessert("img/desserts-png.png", Colors.pink[300]!),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack dessert(String url, Color color) {
    return Stack(
      children: [
        const SizedBox(
          width: 200,
        ),
        Container(
          height: 240,
          width: 170,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sobremesa Natalicía",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              const Text("8000 kz",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600))
            ],
          ),
        ),
        Positioned(
          bottom: -4,
          left: -2,
          child: Image.asset(
            url,
            fit: BoxFit.cover,
            height: 140,
          ),
        )
      ],
    );
  }
}
