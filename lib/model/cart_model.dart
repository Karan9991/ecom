
class Cart {
  final String name;
  final String description;
  final String price;
  final int quantity;
  final List<String> imageUrl;

  Cart({required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory Cart.fromJson(Map<String, dynamic> json) =>
      Cart(
          name: json['name'],
          description: json['description'],
          price: json['price'],
          quantity: json['quantity'],
          imageUrl: List.from(json['imageUrl'] ?? []));

  Map<String, dynamic> toJson () => {
    'name': name,
    'description': description,
    'price': price,
    'quantity': quantity,
    'imageUrl': imageUrl,
  };
}
