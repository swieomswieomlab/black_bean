import 'package:black_bean/components.dart';
import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';

class SelectUnitExamPage extends StatefulWidget {
  const SelectUnitExamPage({super.key});

  @override
  State<SelectUnitExamPage> createState() => _SelectUnitExamPageState();
}

class _SelectUnitExamPageState extends State<SelectUnitExamPage> {
  //과목 명 목록 영어, 이미지 이름 찾을 때 씀
  List<String> subject = [
    "korean",
    "math",
    "english",
    "society",
    "science",
    "history"
  ];
  //과목 목록 한국어
  List<String> subjectKor = ["국어", "수학", "영어", "사회", "과학", "한국사"];
  //구현된 과목 번호
  List<int> containedNum = [1];
  bool selected = false;
  int selectedNum = -1;
  String selectedYear = '';
  String selectedRound = '';
  List<String> unitList = ["1","2","3","4","5","6","7","8"];
  int selectedUnitNum = -1;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("모의고사", style: brand(grey09)),
                const SizedBox(
                  height: 24,
                ),
                //TODO: 연습문제 설명 글 추후에 수정 필요
                Text("연습문제에 대한 설명 글입니다.", style: body2(grey07)),
                Text("연습문제에 대한 설명 글입니다.", style: body2(grey07)),
                const SizedBox(
                  height: 62,
                ),
                SizedBox(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          selectSubjectSection(),
                          Container(
                        // margin: const EdgeInsets.only(bottom: 40),
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
                        width: 89,
                      ),
                      selectUnitSection(),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Text(
                      "Start",
                      style: button2(selected ? blue09 : grey02),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (selectedNum != -1) {
                          examStartDialog(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              selectedNum == -1 ? grey02 : blue09),
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(color: Colors.transparent),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            const CircleBorder(),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            const Size(96, 96),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white
                              // selectedNum == -1 ? Colors.grey : Colors.black
                              )),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 44,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
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
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: containedNum.contains(index)
                                              ? selectedNum == index
                                                  ? blue09
                                                  : blue03
                                              : grey01,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      if (selectedNum == index) {
                                        return blue09;
                                      } else if (containedNum
                                          .contains(index)) {
                                        return greyBlue;
                                      } else {
                                        return grey01;
                                      }
                                      // Set the hover color here
                                    } else {
                                      return containedNum.contains(index)
                                          ? selectedNum == index
                                              ? blue09
                                              : mainLightBlue
                                          : grey01;
                                    }
                                  }),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(110, 44)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (containedNum.contains(index)) {
                                      selected = true;
                                      selectedNum = index;
                                    }
                                  });
                                },
                                child: Text(
                                  subjectKor[index],
                                  style: button2(index == selectedNum
                                      ? grey00
                                      : containedNum.contains(index)
                                          ? grey08
                                          : grey04),
                                ),
                              )),
                    ),
                  );
  }

  Visibility selectUnitSection() {
    return Visibility(
                    visible: selected,
                    child: SizedBox(
                      height: 200,
                      width: 400,
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
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.hovered)) {
                                        if (selectedUnitNum == index) {
                                          return blue03;
                                        } else {
                                          return blue01;
                                        }
                                        // Set the hover color here
                                      } else {
                                        return 
                                             selectedUnitNum == index
                                                ? blue03
                                                : grey00;
                                      }
                                    }),
                                    fixedSize: MaterialStateProperty.all<Size>(
                                        const Size(176, 36)),
                                  ),
                                  onPressed: () {
                                    setState(() {
                        selectedUnitNum = index;
                      });
                    },
                    child: Text(
                      unitList[index],
                      style:
                          button2(index == selectedUnitNum ? grey09 : grey08),
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
                  onPressed: () {},
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
