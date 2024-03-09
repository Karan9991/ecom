import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class CategorySection extends StatefulWidget {
//   const CategorySection({super.key});

//   @override
//   State<CategorySection> createState() => _CategorySectionState();
// }

// class _CategorySectionState extends State<CategorySection> {
//   final _firestore = FirebaseFirestore.instance;
//   // final List<String> categories = ['Demo', 'Which', 'Where'];
//   final List<String> categoryImages = [
//     'assets/images/onboard_1.png',
//     'assets/images/onboard_2.png',
//     'assets/images/onboard_3.png',
//   ];

//   Map<String, dynamic> readData = {};
//   List<String> names = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     //fetchCategoryName();
//     super.initState();
//   }

//   Future<List<String>> fetchCategoryName() async {
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await FirebaseFirestore.instance.collection('categories').get();
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> data = snapshot.docs;
//     QueryDocumentSnapshot<Map<String, dynamic>> rt = data.first;
   

//     debugPrint('length check ${data}');

//     for (QueryDocumentSnapshot<Map<String, dynamic>> edata in data) {
//       readData = edata.data();
//       names.add(readData['name']);
//     }

//     await check();
//     return names;
//   }

//   Future<void> check() async {
//     debugPrint('check ... ${names.length}');
//   }



//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<String>>(
//       future: fetchCategoryName(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Data is still loading
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           // Error occurred while fetching data
//           return Text('Error: ${snapshot.error}');
//         } else {
//           // Data has been successfully fetched
//           List<String> dataa = snapshot.data!;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Categories',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: dataa.length,
//                   itemBuilder: (context, index) {
//                     // final category = names[index];
//                     // final name = category['name'];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundImage: AssetImage(categoryImages[index]),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             dataa[index],
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }




class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            final categoryDocs = snapshot.data!.docs;
            return Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryDocs.length,
                itemBuilder: (context, index) {
                  final category = categoryDocs[index];
                  final categoryName = category['name'] ?? 'Unknown';
                  final categoryImageUrl = category['imageUrl'] ?? '';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(categoryImageUrl),
                        ),
                        SizedBox(height: 4),
                        Text(
                          categoryName,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
