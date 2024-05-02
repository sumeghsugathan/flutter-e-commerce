import 'package:flutter/material.dart';
import 'package:nikeapp/models/product.dart';

class Shop extends ChangeNotifier {
  int _count = 0;
  int _type = 1;
  final List<Product> _shop = [
    Product(
      name: "NikeCourt Legacy",
      price: 5695.00,
      description: "Men's Shoes",
      imagePath: 'assets/images/shoe 4.png',
    ),
    Product(
      name: "Nike Motiva",
      price: 9207.00,
      description: "Men's Walking Shoes",
      imagePath: 'assets/images/shoe 5.png',
    ),
    Product(
      name: "Nike Air Max 270",
      price: 14247.00,
      description: "Women's Shoes",
      imagePath: 'assets/images/shoe 1.png',
    ),
    Product(
      name: "Nike Revolution 7",
      price: 3695.00,
      description: "Women's Road Running Shoes",
      imagePath: 'assets/images/shoe 2.png',
    ),
    Product(
      name: "Nike Air Max 90",
      price: 12157.00,
      description: "Women's Shoes",
      imagePath: 'assets/images/shoe 3.png',
    ),
  ];
//user cart
  final List<Product> _cart = [];
  //user favorite
  final List<Product> _favorite = [];

  //get product list
  List<Product> get shop => _shop;

  //get user cart
  List<Product> get cart => _cart;
  List<Product> get favorite => _favorite;

  // add item to cart
  void addToCart(Product item) {
//check if the item already exists in cart
    final existingProductIndex =
        _cart.indexWhere((product) => product.name == item.name);
    if (existingProductIndex != -1) {
      _cart[existingProductIndex].quantity++;
    } else {
      _cart.add(item);
    }
    notifyListeners();
  }

//add to favorites
  void addToFavorite(BuildContext context, Product item) {
    final existingProductIndex =
        _favorite.indexWhere((product) => product.name == item.name);
    if (existingProductIndex != -1) {
      return;
    }
    _favorite.add(item);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Added to favorites',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
    notifyListeners();
  }

  void removeFromFavorite(Product item) {
    _favorite.remove(item);
    notifyListeners();
  }

  //remove item from cart
  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }

  int get count => _count;
  void setCount(int newCount) {
    _count = newCount;
    notifyListeners();
  }

  //to remove item one by one
  void decreaseItemQuantity(Product item) {
    // Find the index of the item in the cart
    int index = _cart.indexOf(item);
    if (index != -1) {
      if (_cart[index].quantity > 1) {
        // If the quantity is more than 1, decrement it by 1
        _cart[index].quantity--;
        notifyListeners();
      }
    }
  }

  int get type => _type;

  void handleRadio(int selectedType) {
    _type = selectedType;
    notifyListeners();
  }

  void toggleFavoriteStatus(Product product) {
    final index = _shop.indexWhere((item) => item.name == product.name);
    if (index != -1) {
      _shop[index].isFavorite = !_shop[index].isFavorite;
      notifyListeners();
    }
  }

  bool isProductInFavorites(Product product) {
    return _favorite.any((item) => item.name == product.name);
  }

  
}
