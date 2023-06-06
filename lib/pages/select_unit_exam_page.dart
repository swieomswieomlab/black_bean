import 'package:black_bean/components.dart';
import 'package:black_bean/model/unit_exam_arguments.dart';
import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';

import '../service/firebase_service.dart';

class SelectUnitExamPage extends StatefulWidget {
  const SelectUnitExamPage({super.key});

  @override
  State<SelectUnitExamPage> createState() => _SelectUnitExamPageState();
}

class _SelectUnitExamPageState extends State<SelectUnitExamPage> {
  final FirebaseService _firebaseService = FirebaseService();
  //과목 명 목록 영어, 이미지 이름 찾을 때 씀
  List<String> degreeList = ['High', 'Middle'];
  List<String> subjectList = [
    "Korean",
    "Math",
    "English",
    "Society",
    "Science",
    "History"
  ];
  //과목 목록 한국어
  List<String> subjectKor = ["국어", "수학", "영어", "사회", "과학", "한국사"];
  //구현된 과목 번호
  bool selectedSubject = false;
  int selectedNum = -1;
  String selectedYear = '';
  String selectedRound = '';
  List<String> unitList = [];
  int selectedUnitNum = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppbar(),
      body: Center(
        child: SingleChildScrollView(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 120),
            width: 1040,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("연습문제", style: Headline(grey09)),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "공부하고 싶은 과목과 단원 하나를 골라 문제를 풀어보세요.\n많이 풀지 않아도 괜찮아요. 한 문제 한 문제 조금씩 함께 해요.",
                  style: body1(grey08),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 92,
                ),
                SizedBox(
                  height: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          selectSubjectSection(),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: mainLightBlue,
                            ),
                            child: Text(
                              "\u{23F3}다른 과목들도 준비중이에요! 조금만 기다려주세요 :)",
                              style: body3(grey07),
                            ),
                          ),
                        ],
                      ),
                      //년도 드랍다운 버튼
                      const SizedBox(
                        width: 55,
                      ),
                      selectUnitSection(),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [const Spacer(), startButton(context)],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  InkWell startButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (selectedNum != -1 && selectedUnitNum != -1) {
          examStartDialog(context);
        }
      },
      child: SizedBox(
        width: 150,
        height: 80,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Start",
            style: title1(
                selectedNum != -1 && selectedUnitNum != -1 ? blue09 : grey02),
          ),
          const SizedBox(
            width: 8,
          ),
          Icon(
            Icons.arrow_outward,
            size: 40,
            color: selectedNum != -1 && selectedUnitNum != -1 ? blue10 : grey02,
          )
        ]),
      ),
    );
  }

  SizedBox selectSubjectSection() {
    return SizedBox(
      height: 130,
      width: 400,
      child: Wrap(
        spacing: 12,
        runSpacing: 16,
        children: List.generate(
          6,
          (index) => ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (selectedNum == index) {
                    return blue10;
                  }
                  if (states.contains(MaterialState.hovered)) {
                    return grey00; // Set the text color when hovered
                  }
                  return getButtonTextStyle(
                      index); // Set the default text color
                },
              ),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(
                    color: getButtonTextStyle(index),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (selectedNum == index) {
                    return yellowButton;
                  }
                  if (states.contains(MaterialState.hovered)) {
                    return blue08; // Set the desired background color when hovered
                  }
                  return getColor(index); // Set the default background color
                },
              ),
              fixedSize: MaterialStateProperty.all<Size>(const Size(110, 44)),
            ),
            onPressed: () async {
              setState(() {
                selectedNum = index;
                selectedSubject = true;
                selectedUnitNum = -1;
                unitList.clear();
              });

              // Load the unit list from Firebase
              unitList = await _firebaseService
                  .loadMajorSectionNameFromDatabase(
                'High',
                subjectList[index],
              )
                  .then((value) {
                List<String> tmp = [];
                int ind = 1;
                for (var element in value) {
                  tmp.add(element.name);
                  ind += 1;
                }
                return tmp;
              });

              setState(() {
                // Update the state to reflect the loaded unit list
              });
            },
            child: Text(subjectKor[index],
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Pretendard",
                    height: 18 / 18)
                // button2(getButtonTextStyle(index)),
                ),
          ),
        ),
      ),
    );
  }

  Color getColor(int index) {
    if (selectedNum == index) {
      return yellowButton;
    } else {
      return grey00;
    }
  }

  Color getButtonTextStyle(int index) {
    if (index == selectedNum) {
      return blue10;
    } else {
      return grey08;
    }
  }

  Visibility selectUnitSection() {
    return Visibility(
      visible: selectedSubject,
      replacement: const SizedBox(width: 580, height: 300),
      child: SizedBox(
        height: 300,
        width: 580,
        child: Wrap(
          spacing: 12,
          runSpacing: 16,
          children: List.generate(
              unitList.length,
              (index) => ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(
                              color: selectedUnitNum == index ? blue07 : blue05,
                              width: 2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.hovered)) {
                          if (selectedUnitNum == index) {
                            return yellowButton;
                          }
                          if (selectedUnitNum == index) {
                            return blue03;
                          } else {
                            return blue01;
                          }
                          // Set the hover color here
                        } else {
                          return selectedUnitNum == index
                              ? yellowButton
                              : grey00;
                        }
                      }),
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(268, 44)),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedUnitNum = index;
                      });
                    },
                    child: Row(
                      children: [
                        Text("${index + 1}단원",
                            style: button2(
                                index == selectedUnitNum ? blue10 : grey09)),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 180,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              unitList[index],
                              style: body4(
                                  index == selectedUnitNum ? blue10 : grey09),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  Future<dynamic> examStartDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              titlePadding: const EdgeInsets.only(top: 60),
              title: Text("${subjectKor[selectedNum]} 연습문제를 시작할까요?",
                  style: title1(mainBlack), textAlign: TextAlign.center),
              content: Text("시작하기를 누르면 ${selectedUnitNum + 1}단원 연습문제가 시작돼요.",
                  style: body1(grey08), textAlign: TextAlign.center),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              actionsPadding: const EdgeInsets.only(
                  left: 40, right: 40, top: 60, bottom: 36),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(grey03),
                    minimumSize: MaterialStateProperty.all(const Size(238, 64)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "돌아가기",
                    style: button1(grey07),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(238, 64)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(mainSkyBlue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/unitExam',
                        arguments: UnitExamArguments('High',
                            subjectList[selectedNum], selectedUnitNum + 1));
                  },
                  child: Text(
                    "시작하기",
                    style: button1(grey00),
                  ),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ));
  }
}
