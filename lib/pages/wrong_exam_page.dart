import 'package:black_bean/pages/problem_make.dart';
import 'package:flutter/material.dart';

import '../model/unit_exam_arguments.dart';
import '../textstyle.dart';
import '../class/grading_arguments.dart';
import '../model/problem.dart';

import '../service/firebase_service.dart';

//문제 정답 여부 나타내는 enum 변수에 사용
enum AnswerType { basic, wrong, correct }

class WrongExamPage extends StatefulWidget {
  const WrongExamPage({Key? key
      // , required this.arguments
      })
      : super(key: key);
  // final UnitExamArguments arguments;

  @override
  State<WrongExamPage> createState() => _WrongExamPageState();
}

class _WrongExamPageState extends State<WrongExamPage> {
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
  double imageWidth = 520;
  int answer = -1;

  List<int> corrects = [];

  List<String> majorSectionNames = [];

  @override
  void initState() {
    super.initState();
    // var args = widget.arguments;
    // loadProblems(args);
    loadProblems();
  }

  void loadProblems(
      // UnitExamArguments args
      ) async {
    _loadProblemsFuture = _firebaseService
        .loadProblemMajorSectionFromDatabase(
            // args.degree, args.subject, args.unit
            "High",
            "Math",
            1)
        .then((loadedProblems) async {
      finalNumber = loadedProblems.length;
      corrects = List.generate(finalNumber, (index) => 0);
      await loadMajorSectionNames(
          // args
          );
      return loadedProblems;
    });
  }

  Future<void> loadMajorSectionNames(
      // UnitExamArguments args
      ) async {
    return _firebaseService
        .loadMajorSectionNameFromDatabase(
            // args.degree, args.subject
            "High",
            "Math")
        .then((loadedNames) {
      loadedNames.sort((a, b) => a.sectionNumber.compareTo(b.sectionNumber));
      for (var element in loadedNames) {
        majorSectionNames.add(element.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Problem>>(
      future: _loadProblemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: grey00,
              centerTitle: true,
              title: Text(
                "Loading...",
                style: title3(mainBlack),
              ),
            ),
            backgroundColor: grey00,
            body: const Center(
              child:
                  CircularProgressIndicator(), // show progress indicator while loading
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: grey00,
              centerTitle: true,
              title: Text(
                "Error",
                style: title3(mainBlack),
              ),
            ),
            backgroundColor: grey00,
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          _problems = snapshot.data!;
          var mSectionNumber = _problems[_numberState].mSection;
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 120,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 15,
                  color: mainBlack,
                ),
              ),
              backgroundColor: grey00,
              centerTitle: true,
              title: Text(
                "$mSectionNumber단원| ${majorSectionNames[mSectionNumber - 1]}",
                style: title3(mainBlack),
              ),
              actions: <Widget>[
                const SizedBox(
                  height: 29,
                ),
                Row(
                  children: [
                    Center(
                        child: Text(
                      "${_numberState + 1}/${_problems.length}문제",
                      style: body2(yellow06),
                    )),
                    const SizedBox(
                      width: 120,
                    )
                  ],
                )
              ],
            ),
            floatingActionButton: Visibility(
                visible: answerType != AnswerType.basic,
                child: goToUnitProbleButton()),
            backgroundColor: grey00,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: answerType == AnswerType.basic
                          ? grey00
                          : answerType == AnswerType.correct
                              ? green01
                              : red01,
                      border: Border(
                        top: BorderSide(
                          color: answerType == AnswerType.basic
                              ? grey04
                              : answerType == AnswerType.correct
                                  ? pointGreen
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
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            width: 1200,
                            height: MediaQuery.of(context).size.height - 100,
                            child: Column(
                              children: [
                                Container(
                                  width: imageWidth,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    yearToKorean(_problems[_numberState].year),
                                    style: body3(yellow06),
                                  ),
                                ),
                                SizedBox(
                                  width: imageWidth,
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Image.network(
                                      _problems[_numberState].problem,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 1200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                      const SizedBox(
                                        width: 132,
                                      ),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void onRCTap(int index) {
    return setState(() {
      _numberState = index;
    });
  }

  ElevatedButton submitButton() => ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (_selectedNumber == -1) {
                return grey02;
              } else if (answerType == AnswerType.basic) {
                return yellow04;
              } else if (answerType == AnswerType.correct) {
                return pointGreen;
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
              answer = _problems[_numberState].answer;
              if (answerType == AnswerType.basic) {
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
              if (_numberState == finalNumber) {
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
        child: _numberState == finalNumber - 1 && isCorrect
            ? const Text('완료')
            : answerType != AnswerType.basic
                ? const Text('다음')
                : const Text('채점하기'),
      );

  OutlinedButton numberButton(String number, int value) {
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
                  ? yellow04
                  : answerType == AnswerType.correct
                      ? green03
                      : pointRed
              : value == answer
                  ? green03
                  : grey09,
        )),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (isSelected) {
              switch (answerType) {
                case AnswerType.basic:
                  return yellow03;
                case AnswerType.correct:
                  return green02;
                case AnswerType.wrong:
                  return red02;
              }
            } else {
              return value == answer ? green02 : grey00;
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
                  ? yellow04
                  : answerType == AnswerType.correct
                      ? pointGreen
                      : pointRed
              : value == answer
                  ? green03
                  : grey09,
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

  Container goToUnitProbleButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 100, right: 60),
      child: OutlinedButton(
        onPressed: () {
          showStatefulBuilderDialog(context);
          setState(() {});
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          side: const BorderSide(width: 2.0, color: yellow05),
          minimumSize: const Size(211, 44),
        ),
        child: Text(
          "같은 유형 풀러가기 ->",
          style: button2(yellow05),
        ),
      ),
    );
  }

//TODO: DB연결필요
  Future<dynamic> showStatefulBuilderDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        int selectedNumber2 = -1;
        int numberState2 = 0;
        int finalNumber2 = 2;
        int answer2 = -1;
        List<int> corrects2 = [];
        // bool remoteControl = true; // remote control on/off
        AnswerType answerType2 =
            AnswerType.basic; //정답 여부 나타내는 변수. 하단 버튼 부분 색상 변경에 사용.
        bool isCorrect2 = false;
        double spaceBetweenNumbers = 30;

        OutlinedButton numberButton2(String number, int value) {
          bool isSelected2 = selectedNumber2 == value;

          return OutlinedButton(
            onPressed: () {
              setState(() {
                selectedNumber2 = isSelected2 ? -1 : value;
              });
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide(
                color: isSelected2
                    ? answerType2 == AnswerType.basic
                        ? yellow04
                        : answerType2 == AnswerType.correct
                            ? green03
                            : pointRed
                    : value == answer2
                        ? green03
                        : grey09,
              )),
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (states) {
                  if (isSelected2) {
                    switch (answerType2) {
                      case AnswerType.basic:
                        return yellow03;
                      case AnswerType.correct:
                        return green02;
                      case AnswerType.wrong:
                        return red02;
                    }
                  } else {
                    return value == answer2 ? green02 : grey00;
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
                color: isSelected2
                    ? answerType2 == AnswerType.basic
                        ? yellow04
                        : answerType2 == AnswerType.correct
                            ? pointGreen
                            : pointRed
                    : value == answer2
                        ? green03
                        : grey09,
              ),
            ),
          );
        }

        return AlertDialog(
          content: StatefulBuilder(
            builder: (__, StateSetter setState) {
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 92, right: 80, top: 20),
                      child: Text(
                        "1단원|직선의 방정식",
                        style: body3(yellow06),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80, 0, 80, 50),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          alignment: Alignment.topCenter,
                          width: 480,
                          height: 390,
                          child: Image.network(
                            _problems[numberState2].problem,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 66,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 140,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            numberButton2('1', 1),
                            SizedBox(width: spaceBetweenNumbers),
                            numberButton2('2', 2),
                            SizedBox(width: spaceBetweenNumbers),
                            numberButton2('3', 3),
                            SizedBox(width: spaceBetweenNumbers),
                            numberButton2('4', 4),
                          ],
                        ),
                        SizedBox(width: 50,),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (states) {
                                if (selectedNumber2 == -1) {
                                  return grey02;
                                } else if (answerType2 == AnswerType.basic) {
                                  return yellow04;
                                } else if (answerType2 ==
                                    AnswerType.correct) {
                                  return pointGreen;
                                } else {
                                  return pointRed;
                                }
                              },
                            ),
                            fixedSize:
                                MaterialStateProperty.all(const Size(90, 44)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (selectedNumber2 != -1) {
                              // 뭔가 선택했을 때
                              setState(() {
                                answer = _problems[numberState2].answer;
                                if (answerType2 == AnswerType.basic) {
                                  if (answer == selectedNumber2) {
                                    //정답 맞춘 경우 correct
                                    corrects2[numberState2] = 1; // correct
                                    answerType2 = AnswerType.correct;
                                    isCorrect2 = true;
                                  } else {
                                    //정답 못 맞춘 경우 wrong
                                    corrects2[numberState2] = 2; // wrong
                                    answerType2 = AnswerType.wrong;
                                  }
                                } else {
                                  //정답 맞춘 후 '다음' 버튼으로 바뀌고 다음 문제로 넘어가는 부분
                                  answerType2 = AnswerType.basic;
                                  isCorrect2 = false;
                                  numberState2 += 1;
                                  selectedNumber2 = -1;
                                }
                                //if final number, route to grading page
                                if (numberState2 == finalNumber2) {
                                  Navigator.pushNamed(
                                      context, '/unitExamGradingPage',
                                      arguments: GradingArguments(
                                          corrects2, _problems));
                                  numberState2 = 0;
                                }
                              });
                            }
                            // number selected, check if it's correct

                            // when problems are finishied, route to grading page
                            // print("_numberState2: "+_numberState2.toString()+" finalNumber: "+finalNumber.toString());
                          },
                          child:
                              numberState2 == finalNumber2 - 1 && isCorrect2
                                  ? const Text('완료')
                                  : answerType != AnswerType.basic
                                      ? const Text('다음')
                                      : const Text('채점하기'),
                        )
                      ],
                    ),
                  ]);
            },
          ),
        );
      },
    );
  }
}
