class Product {
  final String name;
  final double price;
  final String description;
  int quantity;
  final String imagePath;
  bool isFavorite;

  Product({
    required this.name,
    required this.price,
    required this.description,
    this.quantity = 1,
    required this.imagePath,
    this.isFavorite = false,
  });
}
