import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ProblemMake extends StatefulWidget {
  const ProblemMake({Key? key});

  @override
  State<ProblemMake> createState() => _ProblemMakeState();
}

class _ProblemMakeState extends State<ProblemMake> {
XFile? _image;
final _picker = ImagePicker();
final _storage = FirebaseStorage.instance;

  Future<void> _pickImage() async {
  try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (image != null) {
        setState(() {
          _image = image;
        });
        uploadImage_web(_image!);
        // _uploadImage2(_image!);
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
}

Future<void> _uploadImage(XFile pickedImage) async {
  // Initialize Firebase if it hasn't been initialized yet
  final imageName = DateTime.now().millisecondsSinceEpoch.toString();
  final ref = FirebaseStorage.instance.ref().child('images/$imageName');
      UploadTask uploadTask = ref.putFile(File(pickedImage.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final urlImageUser = await snapshot.ref.getDownloadURL();

  print('Image URL: $urlImageUser');
}


Future<void> uploadImage_web(XFile pickedFile) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ElevatedButton(
            onPressed: (() {
              
            }),
            child: const Text("Upload Image")),
            Center(
        child: _image != null
            ? 
            // Image.file(File(_image!.path))
            Image.network(_image!.path)
            // Text('Picked image: ${_pickedFile!.path}')
            // Image.file(File(_pickedFile!.path))

            : Text('No image selected'),
      ),
        DropdownButtonsFormClass(),
      ],
    ));
  }
}

class DropdownButtonsFormClass extends StatefulWidget {
  const DropdownButtonsFormClass({Key? key});

  @override
  State<DropdownButtonsFormClass> createState() =>
      _DropdownButtonsFormClassState();
}

List<String> degree = ['고졸', '중졸'];
List<String> subject = ['국어', '수학'];
List<String> year = ['2022-1', '2022-2', '2023-1'];
List<String> number = List.generate(20, (i) => (i + 1).toString());
List<String> majorSection = List.generate(4, (i) => (i + 1).toString());
List<String> interSection = List.generate(5, (i) => (i + 1).toString());
List<String> subSection = List.generate(6, (i) => (i + 1).toString());
List<String> answer = List.generate(4, (i) => (i + 1).toString());

class _DropdownButtonsFormClassState extends State<DropdownButtonsFormClass> {
  String? degreeDropdownValue = degree.first;
  String? subjectDropdownValue = subject.first;
  String? yearDropdownValue = year.first;
  String? numberDropdownValue = number.first;
  String? majorSectionDropdownValue = majorSection.first;
  String? interSectionDropdownValue = interSection.first;
  String? subSectionDropdownValue = subSection.first;
  String? answerDropdownValue = answer.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            customDropdownButton(degree, "구분", degreeDropdownValue,
                (value) => degreeDropdownValue = value),
            customDropdownButton(subject, "과목", subjectDropdownValue,
                (value) => subjectDropdownValue = value),
            customDropdownButton(year, "년도", yearDropdownValue,
                (value) => yearDropdownValue = value),
            customDropdownButton(number, "번호", numberDropdownValue,
                (value) => numberDropdownValue = value),
            customDropdownButton(majorSection, "대단원", majorSectionDropdownValue,
                (value) => majorSectionDropdownValue = value),
            customDropdownButton(interSection, "중단원", interSectionDropdownValue,
                (value) => interSectionDropdownValue = value),
            customDropdownButton(subSection, "소단원", subSectionDropdownValue,
                (value) => subSectionDropdownValue = value),
            customDropdownButton(answer, "정답", answerDropdownValue,
                (value) => answerDropdownValue = value),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Submit"))
      ],
    );
  }

  Widget customDropdownButton(List<dynamic> items, String des, String? value,
      Function(String?) onChanged) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          Text(des),
          DropdownButton(
              value: value,
              items: items.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  onChanged(newValue);
                });
              }),
        ],
      ),
    );
  }
}
