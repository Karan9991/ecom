import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadBannerScreen extends StatefulWidget {
  @override
  _UploadBannerScreenState createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  List<File> _selectedImages = [];

  Future<void> _pickImages() async {
    final pickedImages = await _imagePicker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _selectedImages =
            pickedImages.map((image) => File(image.path)).toList();
      });
    }
  }

  Future<void> _uploadImages() async {
    for (var imageFile in _selectedImages) {
      try {
        final ref = _storage
            .ref()
            .child('banners/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(imageFile);
        final imageUrl = await ref.getDownloadURL();
        await _firestore.collection('banners').add({'imageUrl': imageUrl});
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
    setState(() {
      _selectedImages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Banners'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Select Images'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.file(
                      _selectedImages[index],
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedImages.isNotEmpty ? _uploadImages : null,
              child: Text('Upload Images'),
            ),
          ],
        ),
      ),
    );
  }
}
