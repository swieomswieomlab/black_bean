import 'package:black_bean/pages/problem_make.dart';
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
  int finalNumber = 99;
  // bool remoteControl = true; // remote control on/off
  AnswerType answerType = AnswerType.basic; //정답 여부 나타내는 변수. 하단 버튼 부분 색상 변경에 사용.
  bool isCorrect = false;

  List<int> corrects = [];

  @override
  void initState() {
    super.initState();

    _loadProblemsFuture = _firebaseService
        .loadProblemYearFromDatabase('High', 'Math', '2099-1')
        .then((loadedProblems) {
      loadedProblems.sort((a, b) => a.number.compareTo(b.number));
      finalNumber = loadedProblems.length;
      corrects = List.generate(finalNumber, (index) => 0);

      return loadedProblems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Remote controller button section
      // floatingActionButton: remoteControl
      //     ? Container(
      //         color: Colors.white,
      //         margin: const EdgeInsets.only(bottom: 100),
      //         child: ClipOval(
      //           child: SizedBox(
      //             width: 56,
      //             height: 56,
      //             child: OutlinedButton(
      //               onPressed: () {
      //                 setState(() {
      //                   remoteControl = !remoteControl;
      //                 });
      //               },
      //               style: OutlinedButton.styleFrom(
      //                 shape: const CircleBorder(),
      //                 side: const BorderSide(width: 2.0, color: Colors.blue),
      //                 minimumSize: const Size(56, 56),
      //               ),
      //               child: const Icon(Icons.add),
      //             ),
      //           ),
      //         ),
      //       )
      //     : Container(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           border: Border.all(color: const Color(0xffC5D9E9), width: 2),
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //         margin: const EdgeInsets.only(bottom: 100),
      //         width: 280,
      //         height: 270,
      //         child: Column(children: [
      //           Row(
      //             children: [
      //               const SizedBox(width: 40),
      //               Expanded(
      //                 child: Text(
      //                   "문제 리모콘",
      //                   style: Body_Bd1(20, Colors.black),
      //                   textAlign: TextAlign.center,
      //                 ),
      //               ),
      //               IconButton(
      //                 icon: const Icon(Icons.clear),
      //                 hoverColor: Colors.transparent,
      //                 splashColor: Colors.transparent,
      //                 highlightColor: Colors.transparent,
      //                 onPressed: () {
      //                   setState(() {
      //                     remoteControl = !remoteControl;
      //                   });
      //                 },
      //                 alignment: Alignment.centerRight,
      //               ),
      //             ],
      //           ),
      //           Expanded(
      //             child: Container(
      //               padding: const EdgeInsets.all(20),
      //               child: GridView(
      //                 gridDelegate:
      //                     const SliverGridDelegateWithFixedCrossAxisCount(
      //                   crossAxisCount: 5,
      //                   crossAxisSpacing: 10,
      //                   mainAxisSpacing: 10,
      //                 ),
      //                 // spacing: 10,
      //                 // runSpacing: 10,
      //                 children: List.generate(finalNumber, (index) {
      //                   return Container(
      //                     width: 38,
      //                     height: 38,
      //                     decoration: BoxDecoration(
      //                       color: grey01,
      //                       shape: BoxShape.circle,
      //                       border: index == _numberState
      //                           ? Border.all(color: mainSkyBlue, width: 2.0)
      //                           : const Border(),
      //                     ),
      //                     child: InkWell(
      //                       onTap: () {
      //                         onRCTap(index);
      //                       },
      //                       child: Center(
      //                         child: Text(
      //                           "${index + 1}",
      //                           style: index == _numberState
      //                               ? Body_Bd1(14, mainSkyBlue)
      //                               : Body_Bd1(14, grey06),
      //                           softWrap: false,
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 }),
      //               ),
      //             ),
      //           )
      //         ]),
      //       ),
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
                                    style: Tiny_T1(16, mainSkyBlue),
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
                                          number_button('1', 1),
                                          SizedBox(width: spaceBetweenNumbers),
                                          number_button('2', 2),
                                          SizedBox(width: spaceBetweenNumbers),
                                          number_button('3', 3),
                                          SizedBox(width: spaceBetweenNumbers),
                                          number_button('4', 4),
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
                                SizedBox(height: 10,)
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

              //print if problem is correct
              if (corrects[_numberState] == 1) {
                print("Correct!");
              } else {
                print("Wrong!");
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
            ? const Text('결과보기')
            : isCorrect
                ? const Text('다음')
                : const Text('채점하기'),
      );

  void submit() {
    List<int> notSolvedNumbers = checkanswers();
    setState(() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => submitAlertDialog(
            notSolvedNumbers: notSolvedNumbers,
            corrects: corrects,
            problems: _problems),
      );
    });
  }

  OutlinedButton number_button(String number, int value) {
    bool isSelected = _selectedNumber == value;

    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedNumber = isSelected ? -1 : value;
        });
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
        fixedSize: MaterialStateProperty.all(const Size(44, 44)),
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

//현재 사용하지 않는 다이아로그
class submitAlertDialog extends StatelessWidget {
  const submitAlertDialog({
    super.key,
    required this.notSolvedNumbers,
    required this.corrects,
    required List<Problem> problems,
  }) : _problems = problems;

  final List<int> notSolvedNumbers;
  final List<int> corrects;
  final List<Problem> _problems;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(
          top: 60.0, left: 94.0, right: 94.0, bottom: 0.0),
      // insetPadding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 100.0),
      contentPadding: const EdgeInsets.fromLTRB(32.0, 20.0, 32.0, 58.0),
      title: Text(
        notSolvedNumbers.isEmpty ? '시험지를 채점할까요?' : '아직 안 푼 문제가 있어요!',
        style: Headline_H2(36, Colors.black),
        textAlign: TextAlign.center,
      ),
      content: Text(
        notSolvedNumbers.isEmpty
            ? '시험지를 제출하고 문제를 채점하시겠어요?\n문제를 채점한 후에는 다시 되돌릴 수 없어요.'
            : '${(notSolvedNumbers).join(', ')}번 문제를 아직 안 풀었어요.\n그대로 채점할까요? 다시 되돌릴 수 없어요.',
        style: Body_Bd2(24, grey08),
        textAlign: TextAlign.center,
      ),
      actionsPadding: const EdgeInsets.only(
        bottom: 36.0,
      ),
      buttonPadding: const EdgeInsets.all(24),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: grey03,
            minimumSize: const Size(238, 64),
          ),
          child: Text(
            '돌아가기',
            style: Button_Bt1(24, mainBlack),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
            Navigator.popAndPushNamed(context, '/gradingPage',
                arguments: GradingArguments(corrects, _problems));
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: mainSkyBlue,
            minimumSize: const Size(238, 64),
          ),
          child: Text(
            '채점하기',
            style: Button_Bt1(24, Colors.white),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
