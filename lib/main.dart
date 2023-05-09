import 'package:black_bean/pages/full_exam.dart';
import 'package:black_bean/pages/login_page.dart';
import 'package:black_bean/pages/problem_make.dart';
import 'package:black_bean/pages/sign_up_page.dart';
import 'package:black_bean/pages/weakness_exam.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/full_exam.dart';
import 'pages/grading_page.dart';
import 'pages/home_page.dart';
import 'firebase_options.dart';
// import 'pages/image_picker_test.dart';
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
      designSize: Size(1512, 982),
      builder: (context, child) => MaterialApp(
        title: 'Black Bean Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/unitExam',
        routes: {
          '/': (context) => MyHomePage(),
          '/problemMake': (context) => ProblemMake(),
          '/testPage': (context) => TestPage(),
          // '/imageTestPage': (context) => HomePage(),
          '/loginPage': (context) => LoginPage(),
          '/signinPage': (context) => SignUpPage(),
          '/fullExam': (context) => FullExamPage(),
          '/gradingPage': (context) => GradingPage(
              gradingArguments: ModalRoute.of(context)!.settings.arguments
                  as GradingArguments),
          '/weaknessExam': (context) => WeaknessExamPage(),
          '/selectPage': (context) => SelectExamPage(),
          '/unitExam': (context) => UnitExamPage(),
        },
      ),
    );
  }
}
