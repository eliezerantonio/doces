import 'package:danny_doces/models/products/product.dart';
import 'package:danny_doces/screens/edit_product_screen.dart';
import 'package:danny_doces/widgets/messenger.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen(this.product);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                height: 400,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.3,
              left: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      product.image,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("${product.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.orange[400])),
                  const SizedBox(height: 2),
                  Row(
                    children: <Widget>[
                      Text(
                        "${product.price}",
                      ),
                      const Icon(
                        Icons.star_border,
                        size: 19,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 2,
                    width: 300,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 280,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ClipOval(
                              child: Image.asset(
                                "img/PhotoCollage_20210306_154755012.jpg",
                                fit: BoxFit
                                    .cover, // permite escolher a resoluçãio da imagem
                                height: 100,
                                width: 100,
                              ),
                            ),
                            const Text("DripCake"),
                            Row(
                              children: const <Widget>[
                                Text("15000 KZ     "),
                                Icon(
                                  Icons.star_border,
                                  size: 19,
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ClipOval(
                              child: Image.asset(
                                "img/PhotoCollage_20210704_130419962.jpg",
                                fit: BoxFit
                                    .cover, // permite escolher a resoluçãio da imagem
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Text("DripCake"),
                            Row(
                              children: const <Widget>[
                                Text("15000 KZ     "),
                                Icon(
                                  Icons.star_border,
                                  size: 19,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 15,
                left: 10,
                child: Column(children: <Widget>[
                  Text("Detalhes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.brown[600],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                      "Saboreie a vida com os melhores doces", //aqui ficará o titulo do bolo ou sobremesa
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.pink[800])),
                  const Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Text(
                      //aqui vai a descrição do titulo da sobremesa ou bolo
                      "Aqui na Danny Doces você encontra os melhores \ne mais saborosos bolos, sobremesas e muito mais\ntudo aos melhores preços",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.brown[600],
                      ))
                ])),
            Positioned(
              top: 0,
              left: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Positioned(
              top: 0,
              right: 5,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditProductScreen(product)));
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      product.delete();
                      Navigator.pop(context);
                      messenger("Produto eliminado", context);
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
