import 'package:flutter/material.dart';

import '../model/wrong_exam_arguments.dart';
import '../textstyle.dart';
import '../model/problem.dart';

import '../service/firebase_service.dart';

//문제 정답 여부 나타내는 enum 변수에 사용
enum AnswerType { basic, wrong, correct }

class WrongExamPage extends StatefulWidget {
  const WrongExamPage({Key? key, required this.arguments}) : super(key: key);
  final WrongExamArguments arguments;

  @override
  State<WrongExamPage> createState() => _WrongExamPageState();
}

class _WrongExamPageState extends State<WrongExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final double spaceBetweenNumbers = 48;

  late Future<List<Problem>> _loadProblemsFuture;
  late List<Problem> _problems;
  List<List<Problem>> internalProblems = [];
  int _selectedNumber = -1;
  int _numberState = 0;
  late int finalNumber;
  AnswerType answerType = AnswerType.basic;
  bool isCorrect = false;
  double imageWidth = 480;
  int answer = -1;
  bool solved = false;
  Color submitButtonColor = grey02;

  List<String> majorSectionNames = [];

  Color answerLineColor = grey05;
  Color answerLineBackgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    var args = widget.arguments;
    loadProblems(args);
  }

  void loadProblems(WrongExamArguments args) async {
    _loadProblemsFuture =
        Future.value(args.problems).then((loadedProblems) async {
      finalNumber = loadedProblems.length;
      await loadMajorSectionNames(args);
      await loadInternalProblems(args);
      return loadedProblems;
    });
  }

  Future<void> loadInternalProblems(WrongExamArguments args) async {
    List<Problem> problems = args.problems;

    for (int i = 0; i < problems.length; i++) {
      List<Problem> tmp =
          await _firebaseService.loadProblemSmallSectionFromDatabase(
              args.degree,
              args.subject,
              problems[i].mSection,
              problems[i].iSection,
              problems[i].sSection);
      assert(tmp.length == 2);
      internalProblems.add(tmp);
    }
  }

  Future<void> loadMajorSectionNames(WrongExamArguments args) async {
    return _firebaseService
        .loadMajorSectionNameFromDatabase(args.degree, args.subject)
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
                child: goToUnitProbleButton(internalProblems[_numberState])),
            backgroundColor: grey00,
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: answerLineBackgroundColor,
                      border: Border(
                        top: BorderSide(
                          color: answerLineColor,
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
              return submitButtonColor;
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
            setState(() {
              if (!solved) {
                //채점
                solved = true;
                answer = _problems[_numberState].answer;
                if (_selectedNumber == answer) {
                  answerType = AnswerType.correct;
                  submitButtonColor = green03;
                  answerLineColor = green03;
                  answerLineBackgroundColor = green01;
                } else {
                  answerType = AnswerType.wrong;
                  submitButtonColor = red03;
                  answerLineColor = red03;
                  answerLineBackgroundColor = red01;
                }
              } else {
                //다음
                if (_numberState == finalNumber - 1) {
                  Navigator.pop(context);
                } else {
                  submitButtonColor = grey02;
                  answerType = AnswerType.basic;
                  answerLineColor = grey05;
                  answerLineBackgroundColor = Colors.white;
                  _numberState += 1;
                  solved = false;
                  _selectedNumber = -1;
                  answer = -1;
                }
              }
            });
          }
        },
        child: !solved
            ? Text(
                "채점",
                style: button2(grey00),
              )
            : _numberState == finalNumber - 1
                ? Text(
                    "완료",
                    style: button2(grey00),
                  )
                : Text(
                    "다음",
                    style: button2(grey00),
                  ),
      );

  OutlinedButton numberButton(String number, int value) {
    bool isSelected = _selectedNumber == value;
    return OutlinedButton(
      onPressed: () {
        if (!solved) {
          setState(() {
            if (isSelected) {
              submitButtonColor = grey02;
            } else {
              submitButtonColor = yellow05;
            }
            _selectedNumber = isSelected ? -1 : value;
          });
        }
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

  Container goToUnitProbleButton(List<Problem> problems) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100, right: 60),
      child: OutlinedButton(
        onPressed: () {
          showStatefulBuilderDialog(context, problems);
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

  Future<dynamic> showStatefulBuilderDialog(
      BuildContext context, List<Problem> problems) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int numberState = 0;
        int finalNumber = problems.length;
        double spaceBetweenNumbers = 30;
        int answer = problems[numberState].answer;
        List<Color> textColors = List.generate(5, (i) => grey07);
        List<Color> backgroundColors =
            List.generate(5, (i) => Colors.transparent);
        bool solved = false;

        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSet) {
              OutlinedButton numberButtonIn(String number, int value,
                  Color textColor, Color backgroundColor) {
                return OutlinedButton(
                  onPressed: () {
                    stateSet(
                      () {
                        if (!solved) {
                          solved = true;
                          if (answer == value) {
                            textColors[value] = green03;
                            backgroundColors[value] = green02;
                          } else {
                            textColors[value] = red03;
                            backgroundColors[value] = red02;
                            textColors[answer] = green03;
                            backgroundColors[answer] = green02;
                          }
                        }
                      },
                    );
                  },
                  style: ButtonStyle(
                    side:
                        MaterialStateProperty.all(BorderSide(color: textColor)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        return backgroundColor;
                      },
                    ),
                    fixedSize: MaterialStateProperty.all(const Size(40, 40)),
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                  child: Text(
                    number,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: textColor),
                  ),
                );
              }

              return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 92, right: 80, top: 20),
                      child: Text(
                        "${problems[numberState].mSection}단원|랄랄루",
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
                            problems[numberState].problem,
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
                    const SizedBox(
                      height: 66,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 140,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            numberButtonIn(
                                '1', 1, textColors[1], backgroundColors[1]),
                            SizedBox(width: spaceBetweenNumbers),
                            numberButtonIn(
                                '2', 2, textColors[2], backgroundColors[2]),
                            SizedBox(width: spaceBetweenNumbers),
                            numberButtonIn(
                                '3', 3, textColors[3], backgroundColors[3]),
                            SizedBox(width: spaceBetweenNumbers),
                            numberButtonIn(
                                '4', 4, textColors[4], backgroundColors[4]),
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        !solved
                            ? const SizedBox(
                                width: 90,
                                height: 44,
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                                      return yellow05;
                                    },
                                  ),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(90, 44)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  stateSet(
                                    () {
                                      if (numberState != finalNumber - 1) {
                                        numberState += 1;
                                        solved = false;
                                        answer = problems[numberState].answer;
                                        textColors =
                                            List.generate(5, (i) => grey07);
                                        backgroundColors = List.generate(
                                            5, (i) => Colors.transparent);
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                  );
                                },
                                child: numberState == finalNumber - 1
                                    ? Text(
                                        '완료',
                                        style: body3(grey00),
                                      )
                                    : Text(
                                        '다음',
                                        style: body3(grey00),
                                      ),
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
