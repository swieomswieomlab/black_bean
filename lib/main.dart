import 'package:black_bean/pages/full_exam.dart';
import 'package:black_bean/pages/full_exam_grading_page.dart';
import 'package:black_bean/pages/login_page.dart';
import 'package:black_bean/pages/problem_make.dart';
import 'package:black_bean/pages/sign_up_page.dart';
import 'package:black_bean/pages/unit_exam_grading_page.dart';
import 'package:black_bean/pages/weakness_exam.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/grading_page.dart';
import 'pages/home_page.dart';
import 'firebase_options.dart';
import 'pages/select_exam_page.dart';
import 'pages/test_page.dart';
import 'class/grading_arguments.dart';
import 'package:flutter/foundation.dart';

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
        initialRoute: '/unitExam',
        routes: {
          '/': (context) => const MyHomePage(),
          '/problemMake': (context) => const ProblemMake(),
          '/testPage': (context) => TestPage(),
          // '/imageTestPage': (context) => HomePage(),
          '/loginPage': (context) => const LoginPage(),
          '/signinPage': (context) => SignUpPage(),
          '/fullExam': (context) => const FullExamPage(),
          '/fullExamGradingPage' :(context) => FullExamGradingPage(),
          '/weaknessExam': (context) => WeaknessExamPage(),
          '/selectPage': (context) => SelectExamPage(),
          '/unitExam': (context) => UnitExamPage(),
          '/unitExamGradingPage': (context) => UnitExamGradingPage(),

        },
      ),
    );
  }
}
