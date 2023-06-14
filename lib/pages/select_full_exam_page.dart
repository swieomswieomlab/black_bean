import 'package:flutter/material.dart';
import '../components.dart';
import '../model/full_exam_arguments.dart';
import '../textstyle.dart';

class SelectFullExamPage extends StatefulWidget {
  const SelectFullExamPage({super.key});

  @override
  State<SelectFullExamPage> createState() => _SelectFullExamPageState();
}

class _SelectFullExamPageState extends State<SelectFullExamPage> {
  List<String> subject = [
    "Korean",
    "Math",
    "English",
    "Social",
    "Science",
    "History"
  ];

  List<String> subjectKor = ["국어", "수학", "영어", "사회", "과학", "한국사"];
  bool isSelectedSubject = false;
  bool isSelectedYear = false;
  bool isSelectedRound = false;
  int selectedNum = -1;
  String selectedYear = '';
  String selectedRound = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppbar(context),
      backgroundColor: grey00,
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
                Text("모의고사", style: Headline(grey09)),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "실제 검정고시 시험 치듯 문제를 풀어볼 수 있어요.\n긴장하지 않고 편안한 마음으로 끝까지 파이팅 해보아요!",
                  style: body1(grey08),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 92,
                ),
                subjectAndYearSelect(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 60),
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
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        if (canRoute) examStartDialog(context);
                      },
                      child: SizedBox(
                        width: 150,
                        height: 80,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start",
                                style: title1(canRoute ? blue09 : grey02),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_outward,
                                size: 40,
                                color: canRoute ? blue10 : grey02,
                              )
                            ]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  bool get canRoute => isSelectedSubject && isSelectedYear && isSelectedRound;

  Row subjectAndYearSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        subjectSelect(),
        const SizedBox(width: 136),
        yearSelect(),
        const SizedBox(width: 24),
        roundSelect(),
      ],
    );
  }

  Container roundSelect() {
    return Container(
      width: 180,
      height: 38,
      decoration: BoxDecoration(
        border: Border.all(color: grey05),
      ),
      child: DropdownButton<String>(
        alignment: AlignmentDirectional.center,
        value: selectedRound,
        onChanged: (String? newValue) {
          setState(() {
            selectedRound = newValue!;
            if (selectedRound == '') {
              isSelectedRound = false;
            } else {
              isSelectedRound = true;
            }
          });
        },
        items: <String>[
          '',
          '1',
          '2',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value == "" ? "  차수" : "  $value차",
              style: body2(selectedRound == value ? mainBlack : grey05),
            ),
          );
        }).toList(),
        isExpanded: true,
        underline: Container(),
        dropdownColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  Container yearSelect() {
    return Container(
      width: 180,
      height: 38,
      decoration: BoxDecoration(
        border: Border.all(color: grey05),
      ),
      child: DropdownButton<String>(
        alignment: AlignmentDirectional.center,
        value: selectedYear,
        onChanged: (String? newValue) {
          setState(() {
            selectedYear = newValue!;
            if (selectedYear == '') {
              isSelectedYear = false;
            } else {
              isSelectedYear = true;
            }
          });
        },
        items: <String>['', '2021', '2022', '2023']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              "  $value년도",
              style: body2(selectedYear == value ? mainBlack : grey05),
            ),
          );
        }).toList(),
        isExpanded: true,
        underline: Container(),
        dropdownColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  SizedBox subjectSelect() {
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
                            color: getButtonTextStyle(index), width: 2),
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
                        return getColor(
                            index); // Set the default background color
                      },
                    ),
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(110, 44)),
                  ),
                  onPressed: () {
                    setState(() {
                      isSelectedSubject = true;
                      selectedNum = index;
                    });
                  },
                  child: Text(
                    subjectKor[index],
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Pretendard",
                        height: 18 / 18),
                  ),
                )),
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

  Future<dynamic> examStartDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              titlePadding: const EdgeInsets.only(top: 60),
              title: Text("${subjectKor[selectedNum]} 모의고사를 시작할까요?",
                  style: title1(mainBlack), textAlign: TextAlign.center),
              content: Text("시작하기를 누르면 모의고사 문제가 시작돼요.",
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
                  onPressed: routeFullExam,
                  child: Text(
                    "시작하기",
                    style: button1(grey00),
                  ),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ));
  }

  void routeFullExam() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/fullExam',
        arguments: FullExamArguments(
            'High', "$selectedYear-$selectedRound", subject[selectedNum]));
  }
}
