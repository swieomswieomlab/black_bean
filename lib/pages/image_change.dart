// ignore_for_file: unused_import, avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:black_bean/textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../model/problem.dart';
import '../service/firebase_service.dart';

class ImageChange extends StatefulWidget {
  const ImageChange({super.key});

  @override
  State<ImageChange> createState() => _ImageChangeState();
}

class _ImageChangeState extends State<ImageChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: const [
          ImageMakeWidget(),
        ],
      ),
    ));
  }
}

class ImageMakeWidget extends StatefulWidget {
  const ImageMakeWidget({super.key});

  @override
  State<ImageMakeWidget> createState() => _ImageMakeWidgetState();
}

List<String> degree = ['High', 'Middle'];
List<String> subject = [
  'Math',
  'Korean',
  'English',
  'Social',
  'Science',
  'History',
  'Ethics'
];
List<String> year = [
  '2020-1',
  '2020-2',
  '2021-1',
  '2021-2',
  '2022-1',
  '2022-2',
  '2023-1',
  '2099-1'
];
List<String> number = List.generate(26, (i) => (i + 1).toString());
// List<String> majorSection = List.generate(9, (i) => (i + 1).toString());
// List<String> interSection = List.generate(9, (i) => (i + 1).toString());
// List<String> smallSection = List.generate(15, (i) => (i + 1).toString());
// List<String> answer = List.generate(4, (i) => (i + 1).toString());

class _ImageMakeWidgetState extends State<ImageMakeWidget> {
  String? degreeDropdownValue = degree.first;
  String? subjectDropdownValue = subject.first;
  String? yearDropdownValue = year.first;
  String? numberDropdownValue = number.first;
  // String? majorSectionDropdownValue = majorSection.first;
  // String? interSectionDropdownValue = interSection.first;
  // String? subSectionDropdownValue = smallSection.first;
  // String? answerDropdownValue = answer.first;
  String imgUrl = ""; //이미지 url 저장
  XFile? _image;
  var url = '';
  final _picker = ImagePicker();
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (image != null) {
        setState(() {
          _image = image;
        });
        imgUrl = _image!.path;
        print("image_change.dart line 69: imgUrl : $imgUrl");
      } else {
        print("image_change.dart line 71:No image is selected.");
      }
    } catch (e) {
      print("image_change.dart line 74: Error while picking file!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: (() {
              _pickImage();
            }),
            child: const Text("Upload Image")),
        SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            height: MediaQuery.of(context).size.height - 240,
            child: Center(
              child: imgUrl.isNotEmpty
                  ? Image.network(imgUrl)
                  : const Text("No image selected"),
            ),
          ),
        ),
        Center(
          child: Row(
            children: [
              customDropdownButton(degree, "구분", degreeDropdownValue,
                  (value) => degreeDropdownValue = value),
              customDropdownButton(subject, "과목", subjectDropdownValue,
                  (value) => subjectDropdownValue = value),
              customDropdownButton(year, "년도", yearDropdownValue,
                  (value) => yearDropdownValue = value),
              customDropdownButton(number, "번호", numberDropdownValue,
                  (value) => numberDropdownValue = value),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            submitImage(context);
          },
          child: Text(
            "Submit",
            style: Headline(mainBlack),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black87)),
            child: const Text('쉽지않다쉽지않다'),
          ),
        ),
      ],
    );
  }

  Future<void> submitImage(BuildContext context) async {
    String imageName =
        "${subjectDropdownValue}_${yearDropdownValue!}_${int.parse(numberDropdownValue!)}.jpg";
    await _firebaseService
        .uploadToStorage(_image!, imageName)
        .then((value) => setState(() {
              imgUrl = value;
            }));
//upload to firebase
    // Problem problem = Problem(
    //     answer: int.parse(answerDropdownValue!),
    //     iSection: int.parse(interSectionDropdownValue!),
    //     mSection: int.parse(majorSectionDropdownValue!),
    //     number: int.parse(numberDropdownValue!),
    //     problem: imgUrl,
    //     sSection: int.parse(subSectionDropdownValue!),
    //     year: yearDropdownValue!);

    DocumentSnapshot documentSnapshot =
        await _firebaseService.getInstanceFromProblem(
            degreeDropdownValue!,
            subjectDropdownValue!,
            yearDropdownValue!,
            int.parse(numberDropdownValue!));

    documentSnapshot.reference.update({'problem': imgUrl});
    //assert _image is not null
    //upload to storage?

    // await _firebaseService.addProblemToDatabase(
    //     degreeDropdownValue!, subjectDropdownValue!, problem);

    await showDialog(
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

    //올리는거 완료되면 이미지 비우기
    setState(() {
      _image = null;
    });
    imgUrl = '';
    //드롭다운 밸류는?
    numberDropdownValue = (int.parse(numberDropdownValue!) + 1).toString();

    // return problem;
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
