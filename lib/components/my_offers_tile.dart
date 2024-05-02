import 'package:flutter/material.dart';
import 'package:nikeapp/models/product.dart';
import 'package:nikeapp/screens/details_page.dart';

class MyOffers extends StatelessWidget {
  final Product product;
  const MyOffers({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(product: product),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          right: 10,
          bottom: 25,
        ),
        width: 200,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(product.imagePath),
                      ),
                    ),
                    width: 200,
                    child: Image.asset(product.imagePath),
                  ),
                  const SizedBox(height: 5),
                  // name
                  Text(
                    textAlign: TextAlign.start,
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  //product description
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
