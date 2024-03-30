
class Product {
  final String name;
  final String description;
  final String price;
  final String availablepieces;
  final List<String> imageUrl;

  Product({required this.name,
    required this.description,
    required this.price,
    required this.availablepieces,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
          name: json['name'],
      description: json['description'],
      price: json['price'],
      availablepieces: json['availablepieces'],
      imageUrl: List.from(json['imageUrl'] ?? []));

  Map<String, dynamic> toJson () => {
    'name': name,
    'description': description,
    'price': price,
    'availablepieces': availablepieces,
    'imageUrl': imageUrl,
  };
}
