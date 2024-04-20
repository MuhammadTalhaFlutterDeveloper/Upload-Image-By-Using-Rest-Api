import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Or import dio if using it
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _imageFile;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    // Replace with your actual API endpoint
    const String url = 'https://your-api-endpoint.com/upload';

    // Use http or dio for the upload request (example using http)
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile(
        'image', _imageFile!.openRead(), await _imageFile!.length(),
        filename: _imageFile!.path.split('/').last));
    var streamedResponse = await request.send();

    // Handle the response based on your API's structure
    if (streamedResponse.statusCode == 200) {
      // Upload successful
      print('Image uploaded successfully!');

      // Show a success message or perform other actions
    } else {
      // Upload failed
      print('Error uploading image: ${streamedResponse.statusCode}');
      // Show an error message or handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile == null
                ? const Text('No image selected.')
                : SizedBox(
                    width: 300, height: 300, child: Image.file(_imageFile!)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Select Image'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                    var snackBar = const SnackBar(
                        content: Text('Image successfully uploaded'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Upload Image'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
