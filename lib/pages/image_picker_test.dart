// ignore_for_file: avoid_print, unused_element, unused_local_variable, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image Picker for Web Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _picker = ImagePicker();
  // XFile? _pickedFile;
  XFile? _image;

//   Future<void> _pickImage() async {
//     print("tap");
// final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _pickedFile = pickedFile as XFile?;
//     });
//     if(pickedFile != null)
//       _uploadImage(pickedFile as File);
//   }

Future<void> _pickImage() async {
  try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (image != null) {
        setState(() {
          _image = image;
        });
        uploadImageWeb(_image!);
        // _uploadImage2(_image!);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker for Web Example'),
      ),
      body: Center(
        child: _image != null
            ? 
            // Image.file(File(_image!.path))
            Image.network(_image!.path)
            // Text('Picked image: ${_pickedFile!.path}')
            // Image.file(File(_pickedFile!.path))

            : const Text('No image selected'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.image),
      ),
    );
  }

//   Future<void> _uploadImage(File pickedImage) async {
//   final storage = FirebaseStorage.instance;
//   final ref = storage.ref().child('images/${DateTime.now().toString()}');
//   await ref.putFile(pickedImage);
//   final imageUrl = await ref.getDownloadURL();
//   print('Image URL: $imageUrl');
// }
Future<void> _uploadImage(XFile pickedImage) async {
  // Initialize Firebase if it hasn't been initialized yet
  final imageName = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseStorage.instance.ref().child('images/$imageName');
      UploadTask uploadTask = ref.putFile(File(pickedImage.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final urlImageUser = await snapshot.ref.getDownloadURL();

  print('Image URL: $urlImageUser');
}

final _storage = FirebaseStorage.instance;

Future<void> uploadImageWeb(XFile pickedFile) async {
  // ignore: unnecessary_null_comparison
  if (pickedFile != null) {
    final snapshot = await _storage
        .ref()
        .child('images/${DateTime.now().toString()}')
        .putData(await pickedFile.readAsBytes());
    print('Upload complete!');
  } else {
    print('No image selected.');
  }
}

Future<void> _uploadImage2(XFile pickedImage) async {
  // Initialize Firebase if it hasn't been initialized yet
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  final storage = FirebaseStorage.instance;
  final imageName = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = storage.ref().child('images/$imageName');
  await ref.putFile(File(pickedImage.path));
  final imageUrl = await ref.getDownloadURL();

  // Save image URL to Firebase database
  final database = FirebaseDatabase.instance;
  final imageRef = database.reference().child('images').push();
  await imageRef.set({'url': imageUrl});

  print('Image URL: $imageUrl');
}
}
