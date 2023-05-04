import 'package:black_bean/components.dart';
import 'package:black_bean/textstyle.dart';
import 'package:flutter/material.dart';

class SelectExamPage extends StatefulWidget {
  const SelectExamPage({super.key});

  @override
  State<SelectExamPage> createState() => _SelectExamPageState();
}

class _SelectExamPageState extends State<SelectExamPage> {
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
  List<String> subject_kor = ["국어", "수학", "영어", "사회", "과학", "한국사"];
  //구현된 과목 번호
  List<int> contained_num = [1];
  bool selected = false;
  int selected_num = -1;
  String selectedYear = '';
  String selectedRound = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: basicAppbar(),
      body: Center(
        child: SingleChildScrollView(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("연습문제", style: Headline_H1(84, Colors.black)),
                SizedBox(
                  height: 62,
                ),
                //TODO: 연습문제 설명 글 추후에 수정 필요
                Text("연습문제에 대한 설명 글입니다.", style: Body_Bd1(26, Colors.black)),
                Text("연습문제에 대한 설명 글입니다.", style: Body_Bd1(26, Colors.black)),
                SizedBox(
                  height: 62,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 130,
                      width: 600,
                      child: Wrap(
                        spacing: 28,
                        runSpacing: 32,
                        children: List.generate(
                            6,
                            (index) => GestureDetector(
                                  onTap: () {
                                    print(index);
                                    setState(() {
                                      if (contained_num.contains(index)) {
                                        selected = true;
                                        selected_num = index;
                                      }
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                          width: 150,
                                          height: 70,
                                          child: Image.asset(
                                            contained_num.contains(index)
                                                ? selected_num == index
                                                    ? "assets/subject_buttons/button_subject_pressed_${subject[index]}.png"
                                                    : "assets/subject_buttons/button_subject_default_${subject[index]}.png"
                                                : "assets/subject_buttons/button_subject_disabled.png",
                                            alignment: Alignment.bottomCenter,
                                            fit: BoxFit.contain,
                                          )),
                                      Positioned.fill(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: selected_num == index
                                                  ? contained_num
                                                          .contains(index)
                                                      ? 0
                                                      : 15
                                                  : 15),
                                          alignment: Alignment.center,
                                          child: Text(subject_kor[index],
                                              textAlign: TextAlign.center,
                                              style:
                                                  Body_Bd1(20, Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                      ),
                    ),
                    //년도 드랍다운 버튼
                    Container(
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
                          });
                        },
                        items: <String>[
                          '',
                          '2021',
                          '2022',
                          '2023'
                        ] //TODO: 여기에 해당 과목 문제 있는 연도 리스트
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              "  $value년도",
                              style: Body_Bd3(20,
                                  selectedYear == value ? mainBlack : grey05),
                            ), //value에 년도 추가되어서 출력
                          );
                        }).toList(),
                        isExpanded: true,
                        underline: Container(),
                        dropdownColor: Colors.white,
                        elevation: 0,
                      ),
                    ),
                    SizedBox(width: 24),
                    //차수 드랍다운 버튼
                    Container(
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
                          });
                        },
                        items: <String>[
                          '',
                          '1',
                          '2',
                        ] //TODO: 여기에 해당 과목 문제 있는 연도 리스트
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value == "" ? "  차수" : "  $value차",
                              style: Body_Bd3(20,
                                  selectedRound == value ? mainBlack : grey05),
                            ), //value에 년도 추가되어서 출력
                          );
                        }).toList(),
                        isExpanded: true,
                        underline: Container(),
                        dropdownColor: Colors.white,
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: mainLightBlue,
                      ),
                      child: Text(
                        "\u{23F3}다른 과목들도 준비중이에요! 조금만 기다려주세요 :)",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        if (selected_num != -1) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    titlePadding: EdgeInsets.only(top: 60),
                                    title: Text(
                                        "${subject_kor[selected_num]} 모의고사를 시작할까요?",
                                        style: Headline_H2(36, mainBlack),
                                        textAlign: TextAlign.center),
                                    content: Text("시작하기를 누르면 모의고사 문제가 시작돼요.",
                                        style: Body_Bd2(24, grey08),
                                        textAlign: TextAlign.center),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    actionsPadding: EdgeInsets.only(
                                        left: 40,
                                        right: 40,
                                        top: 60,
                                        bottom: 36),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(grey03),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(238, 64)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "돌아가기",
                                          style: Button_Bt1(24, grey07),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(238, 64)),
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  mainSkyBlue),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "시작하기",
                                          style: Button_Bt1(24, Colors.white),
                                        ),
                                      ),
                                    ],
                                    actionsAlignment: MainAxisAlignment.center,
                                  ));
                        }
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        size: 44,
                      ),
                      style: ButtonStyle(
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: selected_num == -1
                                  ? Colors.grey
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            CircleBorder(),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(96, 96),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              selected_num == -1 ? Colors.grey : Colors.black)),
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
}
