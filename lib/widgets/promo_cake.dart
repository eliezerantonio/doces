import 'package:danny_doces/models/products/product.dart';
import 'package:danny_doces/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class PromoCake extends StatelessWidget {
  const PromoCake(this.product);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          //Definimos a routa
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(product.name!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[400],
                )),
            Text(
              "${product.price}",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.pink[200]),
            )
          ],
        ),
      ),
    );
  }
}
