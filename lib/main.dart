import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/home_page.dart';
import 'firebase_options.dart';
import 'pages/select_full_exam_page.dart';
import 'pages/select_unit_exam_page.dart';
import 'pages/test_page.dart';
import 'package:flutter/foundation.dart';
import 'pages/full_exam.dart';
import 'pages/full_exam_grading_page.dart';
import 'pages/problem_make.dart';
import 'pages/unit_exam_grading_page.dart';

import 'pages/unit_exam.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // print("web");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1512, 982),

      builder: (context, child) => MaterialApp(
        title: 'Black Bean Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/problemMake',

        routes: {
          '/': (context) => const MyHomePage(),
          '/problemMake': (context) => const ProblemMake(),
          '/testPage': (context) => const TestPage(),
          '/fullExam': (context) => const FullExamPage(),
          '/fullExamGradingPage' :(context) => const FullExamGradingPage(),
          '/selectFullExamPage': (context) => const SelectFullExamPage(),
          '/selectUnitExamPage': (context) => const SelectUnitExamPage(),
          '/unitExam': (context) => const UnitExamPage(),
          '/unitExamGradingPage': (context) => const UnitExamGradingPage(),

        },
      ),
    );
  }
}
