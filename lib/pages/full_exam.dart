import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../textstyle.dart';
import '../class/grading_arguments.dart';
import '../model/problem.dart';

import '../service/firebase_service.dart';

class FullExamPage extends StatefulWidget {
  const FullExamPage({Key? key}) : super(key: key);

  @override
  State<FullExamPage> createState() => _FullExamPageState();
}

class _FullExamPageState extends State<FullExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final double spaceBetweenNumbers = 48;
  //0 for init, 1 for correct, 2 for wrong
  late List<int> _selectedNumbers;

  late Future<List<Problem>> _loadProblemsFuture;
  late List<Problem> _problems;
  int _selectedNumber = -1;
  int _numberState = 0;
  int finalNumber = 99;
  bool remoteControl = true;

  List<int> corrects = [];

  @override
  void initState() {
    super.initState();

    _loadProblemsFuture = _firebaseService
        .loadProblemYearFromDatabase('High', 'Math', '2099-1')
        .then((loadedProblems) {
      loadedProblems.sort((a, b) => a.number.compareTo(b.number));
      finalNumber = loadedProblems.length;
      _selectedNumbers = List.generate(finalNumber, (index) => -1);
      return loadedProblems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: remoteControl
          ? Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 100),
              child: ClipOval(
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
                      side: const BorderSide(width: 2.0, color: Colors.blue),
                      minimumSize: const Size(56, 56),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffC5D9E9), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(bottom: 100),
              width: 280,
              height: 270,
              child: Column(children: [
                Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: Text(
                        "문제 리모콘",
                        style: Body_Bd1(20, Colors.black),
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
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      // spacing: 10,
                      // runSpacing: 10,
                      children: List.generate(finalNumber, (index) {
                        return Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: grey01,
                            shape: BoxShape.circle,
                            border: index == _numberState? Border.all(color: mainSkyBlue, width: 2.0) : const Border(),
                          ),
                          child: InkWell(
                            onTap: () {
                              onRCTap(index);
                            },
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: index == _numberState? Body_Bd1(14, mainSkyBlue) :Body_Bd1(14, grey06),
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
          Positioned(
            bottom: 0,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                // color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
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
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              width: 1200,
                              height: MediaQuery.of(context).size.height - 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 200.0),
                                    child: Column(children: [
                                      IconButton(
                                          onPressed: () {
                                            goPrevious();
                                          },
                                          icon:
                                              const Icon(Icons.arrow_back_ios)),
                                      const Text("이전"),
                                    ]),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        // padding: EdgeInsets.only(left: 220),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //TODO: 단원명 불러오기
                                          "${_problems[_numberState].mSection}단원|단원명",
                                          style: Tiny_T1(16, mainSkyBlue),
                                        ),
                                      ),
                                      FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: _problems[_numberState].problem,
                                        fit: BoxFit.fitWidth,
                                        fadeInDuration: const Duration(milliseconds: 100),
                                      ),
                                      const Spacer(),
                                      // SizedBox(height: 100), //답안에 가리는 부분 없애기 위한 공백
                                      SizedBox(
                                        width: 1000,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          // crossAxisAlignment: CrossAxisAlignment.end, // Align buttons to the bottom

                                          children: [
                                            const SizedBox(width: 140),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width: spaceBetweenNumbers),
                                                numberButton('1', 1),
                                                SizedBox(
                                                    width: spaceBetweenNumbers),
                                                numberButton('2', 2),
                                                SizedBox(
                                                    width: spaceBetweenNumbers),
                                                numberButton('3', 3),
                                                SizedBox(
                                                    width: spaceBetweenNumbers),
                                                numberButton('4', 4),
                                                SizedBox(
                                                    width: spaceBetweenNumbers),
                                              ],
                                            ),
                                            // SizedBox(width: 140),
                                            submitButton(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 200.0),
                                    child: Column(children: [
                                      IconButton(
                                          onPressed: () {
                                            goNext();
                                          },
                                          icon: const Icon(
                                              Icons.arrow_forward_ios)),
                                      const Text("다음"),
                                    ]),
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
        ],
      ),
    );
  }

  void onRCTap(int index) {
    return setState(() {
      _numberState = index;
    });
  }

  ElevatedButton submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size(140, 48)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onPressed: submit,
      child: const Text('채점'),
    );
  }

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
        side: MaterialStateProperty.all(const BorderSide(color: Colors.black)),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (isSelected) {
              return Colors.blue;
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
          color: isSelected ? Colors.white : Colors.black,
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
