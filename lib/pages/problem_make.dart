import 'package:flutter/material.dart';

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
        ElevatedButton(
            onPressed: (() {
              //
            }),
            child: const Text("Upload")),
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
List<String> majorSection = ['1', '2', '3', '4', '5', '6', '7'];
List<String> subSection = ['1', '2', '3', '4'];

class _DropdownButtonsFormClassState extends State<DropdownButtonsFormClass> {
  String? degreeDropdownValue = degree.first;
  String? subjectDropdownValue = subject.first;
  String? yearDropdownValue = year.first;
  String? majorSectionDropdownValue = majorSection.first;
  String? subSectionDropdownValue = subSection.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            customDropdownButton(degree, degreeDropdownValue,
                (value) => degreeDropdownValue = value),
            customDropdownButton(subject, subjectDropdownValue,
                (value) => subjectDropdownValue = value),
            customDropdownButton(year, yearDropdownValue,
                (value) => yearDropdownValue = value),
            customDropdownButton(majorSection, majorSectionDropdownValue,
                (value) => majorSectionDropdownValue = value),
            customDropdownButton(subSection, subSectionDropdownValue,
                (value) => subSectionDropdownValue = value),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Submit"))
      ],
    );
  }

  Widget customDropdownButton(
      List<dynamic> items, String? value, Function(String?) onChanged) {
    return SizedBox(
      width: 100,
      height: 100,
      child: DropdownButton(
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
    );
  }
}
