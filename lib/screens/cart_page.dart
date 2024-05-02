import 'package:flutter/material.dart';
import 'package:nikeapp/components/my_button.dart';
import 'package:nikeapp/models/product.dart';
import 'package:nikeapp/models/shop.dart';
import 'package:nikeapp/screens/payment_page.dart';

import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  int _calculateTotalQuantity(List<Product> cart) {
    int totalQuantity = 0;
    for (var product in cart) {
      totalQuantity += product.quantity;
    }
    return totalQuantity;
  }

  //remove item from cart
  void removeItemFromCart(BuildContext context, Product product) {
    final shop = context.read<Shop>();
    if (product.quantity > 1) {
      shop.decreaseItemQuantity(product);
    } else {
      showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black.withOpacity(.7),
          content: Text(
            "Remove this item from your cart?",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: Theme.of(context).colorScheme.secondary),
          ),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);

                context.read<Shop>().removeFromCart(product);
              },
              child: Text(
                "Yes",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      );
    }
  }

  void addItemToCart(BuildContext context, Product item) {
    final shop = Provider.of<Shop>(context, listen: false);
    shop.addToCart(item);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    final totalQuantity = _calculateTotalQuantity(cart);

    double totalAmount = 0.0;
    for (var item in cart) {
      totalAmount += item.price * item.quantity;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cart (${totalQuantity.toString()})"),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          //cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text("Your cart is empty.."),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];

                      return Container(
                        padding:
                            const EdgeInsets.all(8), // Add padding as needed
                        margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16), // Add margin as needed
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              8), // Add border radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100, // Adjust width as needed
                              height: 100, // Adjust height as needed
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    8), // Add border radius as needed
                                image: DecorationImage(
                                  image: AssetImage(item.imagePath),
                                  fit: BoxFit
                                      .cover, // Ensure the image fills the available space
                                ),
                              ),
                            ),
                            const SizedBox(
                                width:
                                    16), // Add spacing between image and text
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          16, // Adjust font size as needed
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          8), // Add spacing between title and description
                                  Text(
                                    item.price.toString(),
                                    style: const TextStyle(
                                      fontSize:
                                          14, // Adjust font size as needed
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                width:
                                    16), // Add spacing between text and buttons
                            IconButton(
                              onPressed: () =>
                                  removeItemFromCart(context, item),
                              icon: const Icon(Icons.remove),
                            ),
                            Text(item.quantity.toString()), // Display quantity
                            IconButton(
                              onPressed: () => addItemToCart(context, item),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: cart.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        totalAmount.toStringAsFixed(2),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: cart.isNotEmpty
                  ? MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PaymentPage(totalPrice: totalAmount),
                          ),
                        );
                      },
                      width: 150,
                      height: 70,
                      child: Text(
                        textAlign: TextAlign.center,
                        "CHECKOUT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    )
                  : MyButton(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/shop_page',
                        );
                      },
                      width: 150,
                      height: 70,
                      child: Text(
                        textAlign: TextAlign.center,
                        "GO TO SHOP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
