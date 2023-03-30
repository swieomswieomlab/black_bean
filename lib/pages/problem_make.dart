import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../model/problem.dart';
import '../service/firebase_service.dart';

class ProblemMake extends StatefulWidget {
  const ProblemMake({Key? key});

  @override
  State<ProblemMake> createState() => _ProblemMakeState();
}

class _ProblemMakeState extends State<ProblemMake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
          ProblemMakeWidget(),
              ],
            ),
        ));
  }
}

class ProblemMakeWidget extends StatefulWidget {
  const ProblemMakeWidget({Key? key});

  @override
  State<ProblemMakeWidget> createState() => _ProblemMakeWidgetState();
}

List<String> degree = ['High', 'Middle'];
List<String> subject = ['Math', 'Korean'];
List<String> year = ['2022-1', '2022-2', '2023-1'];
List<String> number = List.generate(22, (i) => (i + 1).toString());
List<String> majorSection = List.generate(9, (i) => (i + 1).toString());
List<String> interSection = List.generate(9, (i) => (i + 1).toString());
List<String> subSection = List.generate(9, (i) => (i + 1).toString());
List<String> answer = List.generate(4, (i) => (i + 1).toString());

class _ProblemMakeWidgetState extends State<ProblemMakeWidget> {
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
        print("problem_make.dart line 69: imgUrl : $imgUrl");
      } else {
        print("problem_make.dart line 71:No image is selected.");
      }
    } catch (e) {
      print("problem_make.dart line 74: Error while picking file!");
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
              submitProblem(context);
            },
            child: const Text("Submit"))
      ],
    );
  }

  Problem submitProblem(BuildContext context) {
//upload to firebase
    Problem problem = Problem(
        answer: int.parse(answerDropdownValue!),
        iSection: int.parse(interSectionDropdownValue!),
        mSection: int.parse(majorSectionDropdownValue!),
        number: int.parse(numberDropdownValue!),
        problem: imgUrl,
        sSection: int.parse(subSectionDropdownValue!),
        year: yearDropdownValue!);

    //assert _image is not null
    //upload to storage?
    String imageName = "${problem.year}_${problem.number.toString()}.jpg";
    _firebaseService.uploadImage_web(_image!, imageName);

    _firebaseService.addProblemToDatabase(
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

    //올리는거 완료되면 이미지 비우기
    setState(() {
      _image = null;
    });
    imgUrl = '';
    //드롭다운 밸류는?
    numberDropdownValue = (int.parse(numberDropdownValue!) + 1).toString();

    return problem;
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
