import 'package:flutter/material.dart';
import 'package:nikeapp/components/my_drawer.dart';
import 'package:nikeapp/components/my_offers_tile.dart';
import 'package:nikeapp/components/my_product_tile.dart';
import 'package:nikeapp/models/shop.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    //access products in shop
    final cart = context.watch<Shop>().cart;
    final products = context.watch<Shop>().shop;
    int totalQuantity = 0;
    for (var item in cart) {
      totalQuantity += item.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "NIKE",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart_page');
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              ),
              Positioned(
                right: 5,
                top: 1,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      totalQuantity.toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20),
            child: Text("Our bestsellers",
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          SizedBox(
            height: 550,
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              itemBuilder: (context, index) {
                final product = products[index];
                return MyProductTile(product: product);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Text("Festival Offers",
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          SizedBox(
            height: 340,
            width: double.infinity,
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final product = products[index];
                return MyOffers(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
