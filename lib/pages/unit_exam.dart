import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../textstyle.dart';
import '../class/grading_arguments.dart';
import '../model/problem.dart';

import '../service/firebase_service.dart';

//문제 정답 여부 나타내는 enum 변수에 사용
enum AnswerType { basic, wrong, correct, checkAnswer }

class UnitExamPage extends StatefulWidget {
  const UnitExamPage({Key? key}) : super(key: key);

  @override
  State<UnitExamPage> createState() => _UnitExamPageState();
}

class _UnitExamPageState extends State<UnitExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final double spaceBetweenNumbers = 48;
  //0 for init, 1 for correct, 2 for wrong
  late List<int> _selectedNumbers;

  late Future<List<Problem>> _loadProblemsFuture;
  late List<Problem> _problems;
  int _selectedNumber = -1;
  int _numberState = 0;
  late int finalNumber;
  // bool remoteControl = true; // remote control on/off
  AnswerType answerType = AnswerType.basic; //정답 여부 나타내는 변수. 하단 버튼 부분 색상 변경에 사용.
  bool isCorrect = false;

  List<int> corrects = [];

  //TODO: REMOVE; TESTING ARGUMENTS
  String testDegree = 'High';
  String testSubject = 'Math';
  int testUnit = 1;

  @override
  void initState() {
    super.initState();

    _loadProblemsFuture = _firebaseService
        .loadProblemMajorSectionFromDatabase(testDegree, testSubject, testUnit)
        .then((loadedProblems) {
      finalNumber = loadedProblems.length;
      corrects = List.generate(finalNumber, (index) => 0);
      return loadedProblems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Exam index here | Subject here",
          style: title3(mainBlack),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: answerType == AnswerType.basic
                    ? Colors.white
                    : answerType == AnswerType.correct
                        ? const Color(0xffF3FFF8)
                        : answerType == AnswerType.checkAnswer
                            ? const Color(0xffFDF7E3)
                            : const Color(0xffFEF5F5),
                border: Border(
                  top: BorderSide(
                    color: answerType == AnswerType.basic
                        ? grey04
                        : answerType == AnswerType.correct
                            ? pointGreen
                            : answerType == AnswerType.checkAnswer
                                ? pointYellow
                                : pointRed,
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 20, top: 20),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 36),
                //exam image
                FutureBuilder<List<Problem>>(
                  future: _loadProblemsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // show progress indicator while loading
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      _problems = snapshot.data!;
                      return Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            width: 1200,
                            height: MediaQuery.of(context).size.height - 100,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 220),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    //TODO: 단원명 불러오기
                                    "${_problems[_numberState].mSection}단원|단원명",
                                    style: body3(mainSkyBlue),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: _problems[_numberState].problem,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // SizedBox(height: 100), //답안에 가리는 부분 없애기 위한 공백
                                SizedBox(
                                  width: 1200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment: CrossAxisAlignment.end, // Align buttons to the bottom

                                    children: [
                                      const SizedBox(width: 280),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: spaceBetweenNumbers),
                                          numberButton('1', 1),
                                          SizedBox(width: spaceBetweenNumbers),
                                          numberButton('2', 2),
                                          SizedBox(width: spaceBetweenNumbers),
                                          numberButton('3', 3),
                                          SizedBox(width: spaceBetweenNumbers),
                                          numberButton('4', 4),
                                          SizedBox(width: spaceBetweenNumbers),
                                        ],
                                      ),
                                      // SizedBox(width: 132),
                                      Visibility(
                                          replacement: const SizedBox(
                                            width: 132,
                                          ),
                                          visible:
                                              AnswerType.wrong == answerType,
                                          child: answerCheckButton()),
                                      submitButton(),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
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
        ],
      ),
    );
  }

  void onRCTap(int index) {
    return setState(() {
      _numberState = index;
    });
  }

  ElevatedButton answerCheckButton() => ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            return pointYellow;
          },
        ),
        fixedSize: MaterialStateProperty.all(const Size(132, 48)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          answerType = AnswerType.checkAnswer;
          _selectedNumber = _problems[_numberState].answer;
          isCorrect = true;
        });
      },
      child: const Text('정답 확인'));

  ElevatedButton submitButton() => ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (_selectedNumber == -1) {
                return grey02;
              } else if (answerType == AnswerType.basic) {
                return mainSkyBlue;
              } else if (answerType == AnswerType.correct) {
                return pointGreen;
              } else if (answerType == AnswerType.checkAnswer) {
                return pointYellow;
              } else {
                return pointRed;
              }
            },
          ),
          fixedSize: MaterialStateProperty.all(const Size(132, 48)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: () {
          if (_selectedNumber != -1) {
            // 뭔가 선택했을 때
            setState(() {
              int answer = _problems[_numberState].answer;

              if (isCorrect == false) {
                if (answer == _selectedNumber) {
                  //정답 맞춘 경우 correct
                  corrects[_numberState] = 1; // correct
                  answerType = AnswerType.correct;
                  isCorrect = true;
                } else {
                  //정답 못 맞춘 경우 wrong
                  corrects[_numberState] = 2; // wrong
                  answerType = AnswerType.wrong;
                }
              } else {
                //정답 맞춘 후 '다음' 버튼으로 바뀌고 다음 문제로 넘어가는 부분
                answerType = AnswerType.basic;
                isCorrect = false;
                _numberState += 1;
                _selectedNumber = -1;
              }
              //if final number, route to grading page
              if (_numberState == finalNumber - 1) {
                Navigator.pushNamed(context, '/unitExamGradingPage',
                    arguments: GradingArguments(corrects, _problems));
                _numberState = 0;
              }
            });
          }
          // number selected, check if it's correct

          // when problems are finishied, route to grading page
          // print("_numberState: "+_numberState.toString()+" finalNumber: "+finalNumber.toString());
        },
        child: _numberState == finalNumber - 2 && isCorrect
            ? const Text('완료')
            : isCorrect
                ? const Text('다음')
                : const Text('채점하기'),
      );

  OutlinedButton numberButton(String number, int value) {
    bool isSelected = _selectedNumber == value;

    return OutlinedButton(
      onPressed: () {
        if (answerType != AnswerType.checkAnswer) {
          setState(() {
            _selectedNumber = isSelected ? -1 : value;
          });
        }
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(
          color: isSelected
              ? answerType == AnswerType.basic
                  ? mainSkyBlue
                  : answerType == AnswerType.correct
                      ? pointGreen
                      : answerType == AnswerType.checkAnswer
                          ? pointYellow
                          : pointRed
              : Colors.black,
        )),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (isSelected) {
              switch (answerType) {
                case AnswerType.basic:
                  return mainLightBlue;
                case AnswerType.correct:
                  return const Color(0xffE7FFF2);
                case AnswerType.wrong:
                  return const Color(0xffFDE5E5);
                case AnswerType.checkAnswer:
                  return const Color(0xffFDF7E3);
              }
            } else {
              return null;
            }
          },
        ),
        fixedSize: MaterialStateProperty.all(const Size(40, 40)),
        shape: MaterialStateProperty.all(const CircleBorder()),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected
              ? answerType == AnswerType.basic
                  ? mainSkyBlue
                  : answerType == AnswerType.correct
                      ? pointGreen
                      : answerType == AnswerType.checkAnswer
                          ? pointYellow
                          : pointRed
              : Colors.black,
        ),
      ),
    );
  }

  int goPrevious() {
    setState(() {
      if (_numberState > 0) {
        _numberState -= 1;
        _selectedNumber = _selectedNumbers[_numberState];
      }
    });
    return _numberState;
  }

  int goNext() {
    setState(() {
      if (_numberState < (finalNumber - 1)) {
        _numberState += 1;
        _selectedNumber = _selectedNumbers[_numberState];
      }
    });
    return _numberState;
  }

  List<int> checkanswers() {
    for (int i = 0; i < finalNumber; i++) {
      if (_selectedNumbers[i] == _problems[i].answer) {
        corrects.add(1);
      } else {
        corrects.add(2);
      }
    }
    List<int> unSolvedNumbers = [];
    for (int i = 0; i < finalNumber; i++) {
      if (_selectedNumbers[i] == -1) {
        unSolvedNumbers.add(i + 1);
      }
    }
    return unSolvedNumbers;
  }
}
