import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  final _imagePicker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  File? _imageFile;

  Future<void> pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);
    }
  }

  Future<void> adCategory(String name) async {
    final ref = _storage.ref('categories').child(name);
    await ref.putFile(_imageFile!);
    final imageUrl = await ref.getDownloadURL();
    _firestore
        .collection('categories')
        .add({'name': name, 'imageUrl': imageUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: pickImage, child: const Text('Pick Image')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  adCategory(nameController.text);
                },
                child: Text('Add Category'))
          ],
        ),
      ),
    );
  }
}



// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddCategoryScreen extends StatefulWidget {
//   @override
//   _AddCategoryScreenState createState() => _AddCategoryScreenState();
// }

// class _AddCategoryScreenState extends State<AddCategoryScreen> {
//   late String _categoryName;
//   File? _imageFile;
//   final picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _uploadCategory() async {
//     if (_imageFile == null || _categoryName.isEmpty) {
//       // Handle error if image or category name is not provided
//       return;
//     }

//     try {
//       // Upload image to Firebase Storage
//       final ref = FirebaseStorage.instance.ref().child('categories').child(_categoryName);
//       await ref.putFile(_imageFile!);
//       final imageUrl = await ref.getDownloadURL();

//       // Store category name and image URL in Firestore
//       await FirebaseFirestore.instance.collection('categories').doc(_categoryName).set({
//         'name': _categoryName,
//         'imageUrl': imageUrl,
//       });

//       // Reset state after successful upload
//       setState(() {
//         _categoryName = '';
//         _imageFile = null;
//       });

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Category uploaded successfully'),
//         backgroundColor: Colors.green,
//       ));
//     } catch (e) {
//       // Handle any errors that occur during upload
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error uploading category: $e'),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Category'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Category Name'),
//               onChanged: (value) => _categoryName = value,
//             ),
//             SizedBox(height: 20),
//             _imageFile == null
//                 ? ElevatedButton(
//                     onPressed: _pickImage,
//                     child: Text('Pick an Image'),
//                   )
//                 : Image.file(_imageFile!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _uploadCategory,
//               child: Text('Upload Category'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
