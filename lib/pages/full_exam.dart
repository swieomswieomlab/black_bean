import 'dart:math';
import 'package:flutter/material.dart';

import '../model/full_exam_arguments.dart';
import '../model/full_grading_arguments.dart';
import '../model/problem.dart';
import '../textstyle.dart';

import '../service/firebase_service.dart';

class FullExamPage extends StatefulWidget {
  const FullExamPage({Key? key, required this.arguments}) : super(key: key);
  final FullExamArguments arguments;

  @override
  State<FullExamPage> createState() => _FullExamPageState();
}

class _FullExamPageState extends State<FullExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final double spaceBetweenNumbers = 44;

  late List<int> _selectedNumbers;

  late Future<List<Problem>> _loadProblemsFuture;
  late List<Problem> problems;
  List<String> majorSectionNames = [];
  int _selectedNumber = -1;
  int _numberState = 0;
  late int finalNumber = 99;
  bool remoteControl = true;
  double imageWidth = 480;
  bool speechBubble = false;

  List<int> corrects = [];

  @override
  void initState() {
    super.initState();
    var args = widget.arguments;
    loadFromFireStore(args);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        speechBubble = true;
      });
    }).then((value) => Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            speechBubble = false;
          });
        }));
  }

  void loadFromFireStore(FullExamArguments args) async {
    _loadProblemsFuture = _firebaseService
        .loadProblemYearFromDatabase(args.degree, args.subject, args.year)
        .then((loadedProblems) async {
      loadedProblems.sort((a, b) => a.number.compareTo(b.number));
      finalNumber = loadedProblems.length;
      _selectedNumbers = List.generate(finalNumber, (index) => -1);
      await loadMajorSectionNames(args);
      return loadedProblems;
    });
  }

  Future<void> loadMajorSectionNames(FullExamArguments args) async {
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
    imageWidth = max(MediaQuery.of(context).size.width * 0.375, 480);
    return FutureBuilder<List<Problem>>(
      future: _loadProblemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "Loading...",
                style: title3(mainBlack),
              ),
            ),
            backgroundColor: Colors.white,
            body: const Center(
              child:
                  CircularProgressIndicator(), // show progress indicator while loading
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          problems = snapshot.data!;
          if (problems.isEmpty) {
            return noProblemPage(context);
          } else {
            var mSectionNumber = problems[_numberState].mSection;
            return Scaffold(
              floatingActionButton:
                  remoteControl ? remoteButton() : remoteController(),
              appBar: AppBar(
                backgroundColor: grey00,
                centerTitle: true,
                title: Text(
                  "${yearToKorean(widget.arguments.year)} | ${subjectToKorean(widget.arguments.subject)}",
                  style: title3(mainBlack),
                ),
              ),
              backgroundColor: grey00,
              body: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        AnimatedOpacity(
                            opacity: speechBubble ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child:
                                Image.asset("assets/images/speech_bubble.png")),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: grey07,
                                width: 1.0,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(bottom: 20, top: 20),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 36),
                        Flexible(
                          fit: FlexFit.tight,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              // width: 1200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: imageWidth,
                                        child: Text(
                                          "$mSectionNumber단원 | ${majorSectionNames[mSectionNumber - 1]}",
                                          style: body3(mainSkyBlue),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: SizedBox(
                                            width: imageWidth,
                                            child: Image.network(
                                              problems[_numberState].problem,
                                              fit: BoxFit.fitWidth,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                      ),
                                      SizedBox(
                                        width: 1100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            answerButtons(),
                                            const SizedBox(
                                              width: 120,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: _numberState ==
                                                      finalNumber - 1
                                                  ? const SizedBox(width: 140)
                                                  : nextButton(),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: submitButton(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
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
        }
      },
    );
  }

  Scaffold noProblemPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "해당 회차에 문제가 없습니다.",
              style: Headline(mainBlack),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "돌아가기",
                  style: Headline(mainBlack),
                ))
          ],
        ),
      ),
    );
  }

  Container remoteController() {
    return Container(
      decoration: BoxDecoration(
        color: grey00,
        border: Border.all(color: blue04, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 100),
      width: 280,
      height: 270,
      child: Column(children: [
        const SizedBox(height: 24),
        Row(
          children: [
            const SizedBox(width: 40),
            Expanded(
              child: Text(
                "문제 리모콘",
                style: title3(grey09),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                setState(() {
                  remoteControl = !remoteControl;
                });
              },
              alignment: Alignment.centerRight,
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: List.generate(finalNumber, (index) {
                return Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: grey01,
                    shape: BoxShape.circle,
                    border: index == _numberState
                        ? Border.all(color: mainSkyBlue, width: 2.0)
                        : const Border(),
                  ),
                  child: InkWell(
                    onTap: () {
                      onRCTap(index);
                    },
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: index == _numberState
                            ? body5(mainSkyBlue)
                            : body5(grey06),
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
    );
  }

  Container remoteButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 100, right: 60),
      child: SizedBox(
        width: 56,
        height: 56,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              remoteControl = !remoteControl;
            });
          },
          style: OutlinedButton.styleFrom(
            shape: const CircleBorder(),
            side: const BorderSide(width: 2.0, color: blue07),
            minimumSize: const Size(56, 56),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Row answerButtons() {
    return Row(
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
    );
  }

  void onRCTap(int index) {
    return setState(() {
      _numberState = index;
      _selectedNumber = _selectedNumbers[_numberState];
    });
  }

  ElevatedButton nextButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: _selectedNumber == -1
            ? MaterialStateColor.resolveWith((states) => grey02)
            : MaterialStateColor.resolveWith((states) => blue02),
        elevation: MaterialStateProperty.all(0),
        fixedSize: MaterialStateProperty.all(const Size(120, 44)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: _selectedNumber == -1
                  ? const BorderSide(color: Colors.transparent)
                  : const BorderSide(width: 1.4, color: blue09)),
        ),
      ),
      onPressed: goNext,
      child: Text('다음',
          style: _selectedNumber == -1 ? button2(grey00) : button2(blue09)),
    );
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => blue09),
        elevation: MaterialStateProperty.all(0),
        fixedSize: MaterialStateProperty.all(const Size(120, 44)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
      onPressed: submit,
      child: Text('채점', style: button2(grey00)),
    );
  }

  void submit() {
    List<int> notSolvedNumbers = checkanswers();
    setState(() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => SubmitAlertDialog(
            degree: widget.arguments.degree,
            subject: widget.arguments.subject,
            notSolvedNumbers: notSolvedNumbers,
            corrects: corrects,
            problems: problems),
      );
    });
  }

  OutlinedButton numberButton(String number, int value) {
    bool isSelected = _selectedNumber == value;

    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedNumber = isSelected ? -1 : value;
          _selectedNumbers[_numberState] = _selectedNumber;
        });
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(
            BorderSide(color: isSelected ? blue10 : grey07)),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (isSelected) {
              return blue02;
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
          color: isSelected ? blue10 : grey07,
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
      if (_selectedNumbers[i] == problems[i].answer) {
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

class SubmitAlertDialog extends StatelessWidget {
  const SubmitAlertDialog({
    super.key,
    required this.notSolvedNumbers,
    required this.corrects,
    required this.problems,
    required this.degree,
    required this.subject,
  });

  final List<int> notSolvedNumbers;
  final List<int> corrects;
  final List<Problem> problems;
  final String degree;
  final String subject;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(
          top: 60.0, left: 94.0, right: 94.0, bottom: 0.0),
      contentPadding: const EdgeInsets.fromLTRB(32.0, 20.0, 32.0, 58.0),
      title: Text(
        notSolvedNumbers.isEmpty ? '시험지를 채점할까요?' : '아직 안 푼 문제가 있어요!',
        style: title1(grey09),
        textAlign: TextAlign.center,
      ),
      content: Text(
        notSolvedNumbers.isEmpty
            ? '시험지를 제출하고 문제를 채점하시겠어요?\n문제를 채점한 후에는 다시 되돌릴 수 없어요.'
            : '${(notSolvedNumbers).join(', ')}번 문제를 아직 안 풀었어요.\n그대로 채점할까요? 다시 되돌릴 수 없어요.',
        style: body1(grey08),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: grey03,
            minimumSize: const Size(238, 64),
          ),
          child: Text(
            '돌아가기',
            style: button1(mainBlack),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, '/fullExamGradingPage',
                arguments:
                    FullGradingArguments(degree, subject, corrects, problems));
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: mainSkyBlue,
            minimumSize: const Size(238, 64),
          ),
          child: Text(
            '채점하기',
            style: button1(grey00),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
