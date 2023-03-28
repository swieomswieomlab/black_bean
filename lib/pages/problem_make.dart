import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../class/problem.dart';

class ProblemMake extends StatefulWidget {
  const ProblemMake({Key? key});

  @override
  State<ProblemMake> createState() => _ProblemMakeState();
}

class _ProblemMakeState extends State<ProblemMake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
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

List<String> degree = ['High', 'Middle'];
List<String> subject = ['Math', 'Korean'];
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
  String imgUrl = ""; //이미지 url 저장
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
        imgUrl = _image!.path;
        print("imgUrl : $imgUrl");
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

//web 아닐 때 파이어스토어에 업로드하는 함수, 테스트 필요
  Future<void> _uploadImage(XFile pickedImage) async {
    // Initialize Firebase if it hasn't been initialized yet
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child('images/$imageName');
    UploadTask uploadTask = ref.putFile(File(pickedImage.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final urlImageUser = await snapshot.ref.getDownloadURL();

    print('Image URL: $urlImageUser');
  }

//웹에서 파이어스토어에 이미지 업로드 할 때 사용하는 함수
  Future<void> uploadImage_web(XFile pickedFile) async {
    if (pickedFile != null) {
      final snapshot = await _storage
          .ref()
          .child('images/${DateTime.now().toString()}')
          .putData(await pickedFile.readAsBytes());
      imgUrl = await snapshot.ref.getDownloadURL();
      print('Upload complete!  $imgUrl');
    } else {
      print('No image selected.');
    }
  }

  var url = '';
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: (() {
              _pickImage();
            }),
            child: const Text("Upload Image")),
        Center(
          child: _image != null
              ?
              // Image.file(File(_image!.path))
              Image.network(imgUrl)
              // Text('Picked image: ${_pickedFile!.path}')
              // Image.file(File(_pickedFile!.path))

              : Text('No image selected'),
        ),
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
        ElevatedButton(
            onPressed: () {
              //assert _image is not null
              //upload to storage?
              uploadImage_web(_image!);
              //upload to firebase
              Problem problem = Problem(
                  answer: int.parse(answerDropdownValue!),
                  iSection: int.parse(interSectionDropdownValue!),
                  mSection: int.parse(majorSectionDropdownValue!),
                  number: int.parse(numberDropdownValue!),
                  problem: imgUrl,
                  sSection: int.parse(subSectionDropdownValue!),
                  year: yearDropdownValue!);

              firestoreService.addProblemToDatabase(
                  degreeDropdownValue!, subjectDropdownValue!, problem);

              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      actions: <Widget>[
                        TextButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            child: const Text("OK"))
                      ],
                    );
                  }));
            },
            child: const Text("Submit"))
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
