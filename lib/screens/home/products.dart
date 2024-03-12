import 'package:ecom/model/product_%20model.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  Products({super.key});
  final List<Product> products = [
    Product(name: 'Product 1', image: 'assets/images/onboard_1.png', price: 10),
    Product(name: 'Product 2', image: 'assets/images/onboard_2.png', price: 20),
    Product(name: 'Product 3', image: 'assets/images/onboard_3.png', price: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics:const NeverScrollableScrollPhysics(),
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 0.9,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:const EdgeInsets.all(5.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      products[index].image,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding:const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${products[index].price}',
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              // Add your favorite icon onPressed logic here
                            },
                            icon:const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
