import 'dart:js_util';

import 'package:flutter/material.dart';

import '../model/problem.dart';

import '../service/firebase_service.dart';

class FullExamPage extends StatefulWidget {
  FullExamPage({Key? key}) : super(key: key);

  @override
  State<FullExamPage> createState() => _FullExamPageState();
}

class _FullExamPageState extends State<FullExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  double space_between_numbers_and_submit = 180;
  double space_between_numbers = 20;
  //0 for init, 1 for correct, 2 for wrong
  List<int> corrects = List.generate(21, (index) => 0);

  late Future<List<Problem>> _loadProblemsFuture;
  late List<Problem> _problems;
  int _selectedNumber = -1;
  int _numberState = 0;

  @override
  void initState() {
    super.initState();
    _loadProblemsFuture = _firebaseService
        .loadProblemYearFromDatabase('High', 'Math', '2022-1')
        .then((loadedProblems) {
      loadedProblems.sort((a, b) => a.number.compareTo(b.number));
      return loadedProblems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Exam index here | Subject here"),
      ),
      body: Center(
        child: Column(
          children: [
            //exam image
            FutureBuilder<List<Problem>>(
              future: _loadProblemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // show progress indicator while loading
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  _problems = snapshot.data!;
                  return Container(
                    child: Image.network(
                      _problems[_numberState].problem,
                    ),
                  );
                }
              },
            ),
            Expanded(child: Container()),
            Divider(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: space_between_numbers_and_submit + 80),
                        number_button('1', 1),
                        SizedBox(width: space_between_numbers),
                        number_button('2', 2),
                        SizedBox(width: space_between_numbers),
                        number_button('3', 3),
                        SizedBox(width: space_between_numbers),
                        number_button('4', 4),
                        SizedBox(width: space_between_numbers_and_submit),
                        submit_button(),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton submit_button() => ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(80, 30)),
        ),
        onPressed: () {
          if (_selectedNumber == -1) {
            // no number selected
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please select a number')),
            );
          } else {
            // number selected, check if it's correct
            setState(() {
              int answer = _problems[_numberState].answer;
              if (answer == _selectedNumber) {
                corrects[_numberState] = 1; // correct
              } else {
                corrects[_numberState] = 2; // wrong
              }
              _numberState += 1;
              _selectedNumber = -1;
              print(corrects);
            });
          }
        },
        child: Text('저장'),
      );

  OutlinedButton number_button(String number, int value) {
    bool isSelected = _selectedNumber == value;

    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedNumber = isSelected ? -1 : value;
        });
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (isSelected) {
              return Colors.blue;
            } else {
              return null;
            }
          },
        ),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}