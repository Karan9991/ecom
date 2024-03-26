import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  String? mainImage; // Initialize mainImage variable
  bool _favouriteToggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                ClipRRect(borderRadius: BorderRadius.circular(8.0),
                  child:
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0
                      )
                    ),
                    child: Image.asset(
                      mainImage ?? widget.product['imageUrl'],
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
            ),

            const SizedBox(height: 16.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var image in widget.product['images'])
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mainImage = image;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: mainImage == image
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
             SizedBox(height: 16.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\$${widget.product['price']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product['description'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16.0),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Quantity:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){
                        setState(() {
                          if(_quantity > 1) {
                            _quantity--;
                          }
                        });

                      }, icon: Icon(Icons.remove)),
                      Text('$_quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

                      IconButton(onPressed: (){
                        setState(() {
                          _quantity++;

                        });
                      }, icon: Icon(Icons.add)),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _favouriteToggle = !_favouriteToggle;
                          });
                        },
                        icon: Icon(_favouriteToggle ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
                      ),
                    ],

                  ),

                  const SizedBox(height: 16.0,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () {
                        // Implement Add to Cart functionality here
                      },
                      child: const Text('Add to Cart', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

}
