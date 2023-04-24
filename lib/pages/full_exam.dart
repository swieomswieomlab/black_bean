import 'dart:js_util';

import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../class/grading_arguments.dart';
import '../model/problem.dart';

import '../service/firebase_service.dart';

class FullExamPage extends StatefulWidget {
  FullExamPage({Key? key}) : super(key: key);

  @override
  State<FullExamPage> createState() => _FullExamPageState();
}

class _FullExamPageState extends State<FullExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  double space_between_numbers = 48;
  //0 for init, 1 for correct, 2 for wrong
  late List<int> corrects;

  late Future<List<Problem>> _loadProblemsFuture;
  late List<Problem> _problems;
  int _selectedNumber = -1;
  int _numberState = 0;
  int finalNumber = 99;
  bool remote_control = true;
  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController1.addListener(() {
      _scrollController2.animateTo(_scrollController1.offset,
          duration: Duration(microseconds: 1), curve: Curves.ease);
    });

    _loadProblemsFuture = _firebaseService
        .loadProblemYearFromDatabase('High', 'Math', '2022-1')
        .then((loadedProblems) {
      loadedProblems.sort((a, b) => a.number.compareTo(b.number));
      finalNumber = loadedProblems.length;
      corrects = List.generate(finalNumber, (index) => 0);
      // print("Number of problems: " + finalNumber.toString());
      return loadedProblems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: remote_control
          ? 
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: ClipOval(
  child: SizedBox(
    width: 56,
    height: 56,
    child: OutlinedButton(
      onPressed: () {
        setState(() {
            remote_control = !remote_control;
          });
      },
      child: Icon(Icons.add),
      style: OutlinedButton.styleFrom(
      shape: CircleBorder(),
      side: BorderSide(width: 2.0, color: Colors.blue),
      minimumSize: Size(56, 56),
    ),
    ),
  ),
),
          )
          : 

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffC5D9E9), width: 2),
    borderRadius: BorderRadius.circular(8),
  ),
            margin: EdgeInsets.only(bottom: 100),
            width: 280,
            height: 270,
            child: Column(children: [
              Row(
  children: [
    SizedBox(width: 40),
    Expanded(
      child: Text(
        "문제 리모콘",
        style: Body_Bd1(20, Colors.black),
        textAlign: TextAlign.center,
      ),
    ),
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        setState(() {
          remote_control = !remote_control;
        });
      },
      alignment: Alignment.centerRight,
    ),
  ],
),
              Expanded(
                child: Container(
                  
                  padding: EdgeInsets.all(20),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    // spacing: 10,
                    // runSpacing: 10,
                    children: 
                    List.generate(20, (index) {
                    return Container(
  width: 38,
  height: 38,
  decoration: BoxDecoration(
    color: grey01,
    shape: BoxShape.circle,
  ),
  child: InkWell(
    onTap: () {
      setState(() {
        remote_control = !remote_control;
      });
    },
    child: Center(
      child: Text(
        "${index+1}",
        style: Body_Bd1(14, grey06),
        softWrap: false,
      ),
    ),
  ),
);
                  }),
                  ),
                ),
              )
            ]),
          ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Exam index here | Subject here",
          style: Headline_H4(26, mainBlack),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
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
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            controller: _scrollController1,
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              width: 1200,
                              height: MediaQuery.of(context).size.height - 100,
                              // color: Colors.redAccent,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 220),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      //TODO: 단원명 불러오기
                                      "${_problems[_numberState].mSection}단원|단원명",
                                      style: Tiny_T1(16, mainSkyBlue),
                                    ),
                                  ),
                                  Container(
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: _problems[_numberState].problem,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Spacer(),
                                  // SizedBox(height: 100), //답안에 가리는 부분 없애기 위한 공백
                                  Container(
                  width: 1200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.end, // Align buttons to the bottom

                    children: [
                      SizedBox(width: 140),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_back_ios)),
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
                      // SizedBox(width: 140),
                      submit_button(),
                    ],
                  ),
                ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                // Expanded(child: Container()),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              padding: EdgeInsets.only(bottom: 20, top: 20),
            ),
          ),
        ],
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
          // number selected, check if it's correct
          setState(() {
            int answer = _problems[_numberState].answer;
            if (answer == _selectedNumber) {
              corrects[_numberState] = 1; // correct
            } else {
              corrects[_numberState] = 2; // wrong
            }
            //print if problem is correct
            if (corrects[_numberState] == 1) {
              print("Correct!");
            } else {
              print("Wrong!");
            }
            //if final number, route to grading page
            if (_numberState == finalNumber - 1) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        Navigator.pushNamed(context, '/gradingPage',
                            arguments: GradingArguments(corrects, _problems));
                        _numberState = 0;
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
            //repetive args
            if (_numberState < finalNumber - 1) {
              _numberState += 1;
            }
            _selectedNumber = -1;
          });
        },
        child: _numberState == finalNumber - 1
            ? const Text('채점')
            : const Text('다음'),
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
