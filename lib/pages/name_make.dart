// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class NameMakePage extends StatelessWidget {
  NameMakePage({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String degree = 'High';
  // String subject = 'Math';
  // List<String> MajorSectionNames = [
  //   '다항식',
  //   '방정식과 부등식',
  //   '도형의 방정식',
  //   '집합과 명제',
  //   '함수와 그래프',
  //   '순열과 조합'
  // ];
  // List<List<String>> InterSectionNames = [
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  // ];
  // List<List<List<String>>> SmallSectionsNames = [
  //   [
  //     ['다항식의 연산', '항등식과 나머지정리', '인수분해']
  //   ],
  //   [
  //     ['복소수', '이차방정식', '이차방정식과 이차함수', '여러가지 방정식', '여러가지 부등식']
  //   ],
  //   [
  //     ['평면좌표', '직선의 방정식', '원의 방정식', '도형의 이동']
  //   ],
  //   [
  //     ['집합', '집합의 연산', '명제']
  //   ],
  //   [
  //     ['함수', '유리함수와 무리함수']
  //   ],
  //   [
  //     ['순열과 조합']
  //   ]
  // ];

  // String subject = 'Korean';
  // List<String> MajorSectionNames = [
  //   '문학',
  //   '독서',
  //   '화법과 작문',
  //   '문법',
  // ];
  // List<List<String>> InterSectionNames = [
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  // ];
  // List<List<List<String>>> SmallSectionsNames = [
  //   [
  //     ['현대 시','고전 시가','현대 소설','고전 소설','수필·극']
  //   ],
  //   [
  //     ['정보 전달 갈래', '설득 갈래', '독서의 방법', '매채 자료 읽기']
  //   ],
  //   [
  //     ['화법','작문']
  //   ],
  //   [
  //     ['음운 체계 및 음운의 변동', '이해를 돕는 문법 개념', '어문 규범','문법 요소','정확한 문장 표현','담화','한글 창제의 원리','국어의 역사']
  //   ],
  // ];

  // String subject = 'English';
  // List<String> MajorSectionNames = [
  //   '문법',
  //   '생활영어',
  //   '어휘',
  //   '독해',
  // ];
  // List<List<String>> InterSectionNames = [
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  // ];
  // List<List<List<String>>> SmallSectionsNames = [
  //   [
  //     ['문장','시제','조동사','능동태와 수동태','동명사','부정사','분사','관계사','명사, 대명사, 관사','가정법','전치사, 접속사','형용사와 부사','비교급과 최상급','일치와 특수 구문']
  //   ],
  //   [
  //     ['장소별 생활영어','상황별 생활영어','기타 생활영어']
  //   ],
  //   [
  //     ['단어','숙어','속담']
  //   ],
  //   [
  //     ['독해의 기본','유형별 독해']
  //   ],
  // ];

  // String subject = 'Science';
  // List<String> MajorSectionNames = [
  //   '물질과 규칙성',
  //   '시스템과 상호 작용',
  //   '변화와 다양성',
  //   '환경과 에너지',
  // ];
  // List<List<String>> InterSectionNames = [
  //   ['물질의 생성','물질의 규칙성','자연의 구성 물질','신소재'],
  //   ['역학적 시스템','지구 시스템','생명 시스템'],
  //   ['산화 환원 반응','산과 염기','지질 시대의 환경과 생물','진화와 생물 다양성'],
  //   ['생태계와 환경','지구 환경 변화','에너지','전기 에너지','태양광 발전과 신재생 에너지'],
  // ];
  // List<List<List<String>>> SmallSectionsNames = [
  //   [
  //     ['스펙트럼과 빅뱅 우주론','별과 태양계의 행성'],
  //     ['주기율표','화학 결합'],
  //     ['지각과 생명체의 구성 물질','생명체의 주요 구성 물질'],
  //     ['우리 생활과 신소재','자연을 모방하여 만든 신소재'],
  //   ],
  //   [
  //     ['역학적 시스템','운동과 충돌'],
  //     ['지구 시스템','지구 시스템과 상호 작용','판 구조론과 지권의 변화'],
  //     ['세포','물질대사','유전 정보의 흐름'],
  //   ],
  //   [
  //     ['산소의 이동에 따른 산화 환원 반응','전자에 이동에 따른 산화 환원 반응','여러 산화 환원 반응'],
  //     ['산과 염기','중화 반응'],
  //     ['지질 시대와 화석','대멸종'],
  //     ['진화','생물 다양성과 보전']
  //   ],
  //   [
  //     ['생물과 환경','생태계 평형'],
  //     ['기후 변화','지구 환경 변화'],
  //     ['에너지의 전환과 보존','에너지 효율과 열효율'],
  //     ['전기 에너지의 생산','전력의 수송'],
  //     ['태양 에너지의 생성과 전환','핵발전, 태양광 발전, 풍력 발전','신재생 에너지']
  //   ],
  // ];

  String subject = 'Social';
  List<String> MajorSectionNames = [
    '인간, 사회, 환경과 행복',
    '자연환경과 인간',
    '생활 공간과 사회',
    '인권 보장과 헌법',
    '시장 경제와 금융',
    '사회 정의와 불평등',
    '문화와 다양성',
    '세계화와 평화',
    '미래와 지속가능한 삶'
  ];
  List<List<String>> InterSectionNames = [
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
    ['noInterSection'],
  ];
  List<List<List<String>>> SmallSectionsNames = [
    [
      ['인간, 사회, 환경을 바라보는 시각','행복의 의미와 기준','행복한 삶을 실현하기 위한 조건'],
    ],
    [
      ['자연환경과 인간 생활','인간과 자연의 관계','환경 문제의 해결을 위한 노력'],
    ],
    [
      ['산업화와 도시화','교통·통신의 발달과 정보화','지역의 공간 변화'],
    ],
    [
      ['인권의 의미와 변화 양상','헌법의 역할과 시민 참여','인권 문제의 양상과 해결 방안'],
    ],
    [
      ['자본주의의 전개 과정과 합리적 선택','시장 경제와 시장 참여자의 역할','국제 무역의 확대와 영향','자산 관리와 금융 생활'],
    ],
    [
      ['정의의 의미과 실질적 기준','다양한 정의관의 특징과 적용','사회 및 공간 불평등 해결과 정의의 실현'],
    ],
    [
      ['세계의 다양한 문화권','문화 변동과 전통문화의 창조적 계승','문화 상대주의와 보편 윤리성 성찰','다문화 사회와 문화적 다양성 존중'],
    ],
    [
      ['세계화의 양상과 문제의 해결','국제 사회의 모습과 평화의 중요성','동아시아 갈등과 국제 평화'],
    ],
    [
      ['세계의 인구와 인구 문제','세계의 자원과 지속 가능한 발전','미래 지구촌의 모습과 내 삷의 방향'],
    ]
  ];

  // String subject = 'History';
  // List<String> MajorSectionNames = [
  //   '전근대 한국사의 이해',
  //   '근대 국민 국가 수립 운동',
  //   '일제 식민지 지배와 민족 운동의 전개',
  //   '대한민국의 발전',
  // ];
  // List<List<String>> InterSectionNames = [
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  //   ['noInterSection'],
  // ];
  // List<List<List<String>>> SmallSectionsNames = [
  //   [
  //     ['고대 국가의 지배 체제', '고대 사회의 종교와 사상', '고려의 통치 체제와 국제 질서의 변동', '고려의 사회와 사상', '조선의 정치 운영과 세계관의 변화','양반 신분제 사화의 상품 화폐 경제']
  //   ],
  //   [
  //     ['서구 열강의 접근과 조선의 대응','동아시아의 변화와 근대적 개혁의 추진','근대 국민 국가 수립을 위한 노력','일본의 침략 확대와 국권 수호 운동','개항 이후 경제와 사회·문화적 변화']
  //   ],
  //   [
  //     ['일제의 식민지 지배 정책','3·1 운동과 대한민국 임시 정부','다양한 민족 운동의 전개','사회·문화의 변화와 사회 운동','전시 동원 체제와 민중의 삶','광복을 위한 노력']
  //   ],
  //   [
  //     ['8·15 광복과 통일 정부 수립을 위한 노력','대한민국 정부 수립과 6·25 전쟁','4·19 혁명과 민주화를 위한 노력','6월 민주 항쟁과 민주주의의 발전','경제 성장과 사회·문화의 변화','남북 화해와 동아시와 평화를 위한 노력'
  //     ]
  //   ],
  // ];

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
