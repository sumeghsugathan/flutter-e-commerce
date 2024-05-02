import 'package:flutter/material.dart';
import 'package:nikeapp/models/product.dart';
import 'package:nikeapp/screens/details_page.dart';

class MyProductTile extends StatelessWidget {
  final Product product;
  const MyProductTile({
    super.key,
    required this.product,
  });

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
        color: Colors.transparent,
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(
          right: 10,
          bottom: 25,
        ),
        width: 300,
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
                  ),
                  width: double.infinity,
                  child: Image.asset(product.imagePath),
                ),
                const SizedBox(height: 5),
                // name
                Text(product.name,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 10),
                //product description
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
