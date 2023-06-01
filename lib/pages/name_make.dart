import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NameMakePage extends StatelessWidget {
  NameMakePage({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String degree = 'High';
  String subject = 'Math';
  List<String> MajorSectionNames = [
    '다항식',
    '방정식과 부등식',
    '도형의 방정식',
    '집합과 명제',
    '함수와 그래프',
    '순열과 조합'
  ];
  // 중단원이 없을 경우 ['noInterSection'], 반복
  List<List<String>> InterSectionNames = [
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
  ];
  // 중단원이 있을 경우
  // List<List<String>> InterSectionNames = [
  //   ['noInterSection'],
  // ];
  List<List<List<String>>> SmallSectionsNames = [
    [
      ['다항식의 연산', '항등식과 나머지정리', '인수분해']
    ],
    [
      ['복소수', '이차방정식', '이차방정식과 이차함수', '여러가지 방정식', '여러가지 부등식']
    ],
    [
      ['평면좌표', '직선의 방정식', '원의 방정식', '도형의 이동']
    ],
    [
      ['집합', '집합의 연산', '명제']
    ],
    [
      ['함수', '유리함수와 무리함수']
    ],
    [
      ['순열과 조합']
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          upload(degree, subject, MajorSectionNames, InterSectionNames,
              SmallSectionsNames);
        },
        child: const Text("PRESS"),
      )),
    );
  }

  void upload(
      String degree,
      String subject,
      List<String> MajorSectionNames,
      List<List<String>> InterSectionsNames,
      List<List<List<String>>> SmallSectionsNames) {
    CollectionReference coref = _firestore
        .collection('degree')
        .doc(degree)
        .collection('subject')
        .doc(subject)
        .collection('MajorSectionName');

    for (int i = 1; i <= MajorSectionNames.length; i++) {
      // Add Major Section Names
      Map<String, dynamic> mData = {'name': MajorSectionNames[i - 1]};
      print("Major : " + MajorSectionNames[i - 1]);
      DocumentReference mDocref = coref.doc(i.toString());
      mDocref.set(mData);
      for (int j = 1; j <= InterSectionsNames[i - 1].length; j++) {
        // Add Inter Section Names
        Map<String, dynamic> iData = {'name': InterSectionsNames[i - 1][j - 1]};
        print(" Inter : " + InterSectionsNames[i - 1][j - 1]);
        DocumentReference iDocref =
            mDocref.collection('InterSectionName').doc(j.toString());
        iDocref.set(iData);
        for (int k = 1; k <= SmallSectionsNames[i - 1][j - 1].length; k++) {
          // Add Small Section Names
          Map<String, dynamic> sData = {
            'name': SmallSectionsNames[i - 1][j - 1][k - 1]
          };
          print("\t" + SmallSectionsNames[i - 1][j - 1][k - 1]);
          iDocref.collection('SmallSectionName').doc(k.toString()).set(sData);
        }
        print('\n');
      }
    }
  }
}
