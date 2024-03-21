// class Product {
//   final String? name;
//   final String? price;
//   final String? description;
//   final String? availablepieces;
//   final List<String>? imageUrl;
//
//   Product({
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.availablepieces,
//     required this.imageUrl
//   });
//
//   factory Product.fromJson(Map<String, dynamic> map) =>
//       Product
//         (
//         name: map['name'],
//         price: map['price'],
//         description: map['description'],
//         availablepieces: map['availablepieces'],
//         imageUrl: map['imageUrl'],
//       );
//
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'price': price,
//     'description': description,
//     'availablepieces': availablepieces,
//     'imageUrl': imageUrl,
//   };
//
// }

class Product {
  final String name;
  final String image;
  final double price;

  Product({required this.name, required this.image, required this.price});
}
