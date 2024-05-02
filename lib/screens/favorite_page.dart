import 'package:flutter/material.dart';
import 'package:nikeapp/models/product.dart';
import 'package:nikeapp/models/shop.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    void addToCart(Product product) {
      showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black.withOpacity(.7),
          content: Text(
            "Add this item to your cart?",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<Shop>().addToCart(product);
                context.read<Shop>().removeFromFavorite(product);
                context.read<Shop>().toggleFavoriteStatus(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Added to cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final favorite = context.watch<Shop>().favorite;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: favorite.isEmpty
          ? const Center(
              child: Text("No favorites"),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8, // Spacing between columns
                mainAxisSpacing: 8, // Spacing between rows
                childAspectRatio: .6,
                // Aspect ratio (width / height) of each grid item
              ),
              itemCount: favorite.length,
              itemBuilder: (context, index) {
                final item = favorite[index];
                return GridTile(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            Image.asset(item.imagePath),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            MaterialButton(
                              color: Colors.black,
                              onPressed: () => addToCart(item),
                              child: Text(
                                "Move to cart",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
