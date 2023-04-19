import 'dart:js_util';

import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';

import '../model/problem.dart';

import '../service/firebase_service.dart';

class WeeknessExamPage extends StatefulWidget {
  WeeknessExamPage({Key? key}) : super(key: key);

  @override
  State<WeeknessExamPage> createState() => _WeeknessExamPageState();
}

class _WeeknessExamPageState extends State<WeeknessExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  double space_between_numbers = 48;
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Exam index here | Subject here", style:Headline_H4(26, mainBlack) ,),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 36),
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
                    width: 820,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //TODO: 단원명 불러오기
                            "${_problems[_numberState].mSection}단원|단원명",
                            style: Tiny_T1(16, mainSkyBlue),),
                        ),
                        Container(
                          child: Image.network(
                            _problems[_numberState].problem,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Expanded(child: Container()),
            Divider(),
            Container(
              padding: EdgeInsets.only(bottom: 51, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 140),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [

                      Column(children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                        Text("이전"),
                      ]),
                      SizedBox(width: space_between_numbers),
                      number_button('1', 1),
                      SizedBox(width: space_between_numbers),
                      number_button('2', 2),
                      SizedBox(width: space_between_numbers),
                      number_button('3', 3),
                      SizedBox(width: space_between_numbers),
                      number_button('4', 4),
                      SizedBox(width: space_between_numbers),
                      Column(children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios)),
                        Text("다음"),
                      ]),
                    ],
                  ),
                  submit_button(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 ElevatedButton submit_button() => ElevatedButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(140, 48)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
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
        child: Text('채점',style:Button_Bt2(20, Colors.white),),
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
        fixedSize: MaterialStateProperty.all(Size(44, 44)),
        shape: MaterialStateProperty.all(CircleBorder()),
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
