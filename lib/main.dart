import 'package:black_bean/model/unit_exam_arguments.dart';
import 'package:black_bean/pages/name_make.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/full_exam_arguments.dart';
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
import 'pages/wrong_exam_page.dart';

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
          // '/fullExam': (context) => const FullExamPage(),
          '/fullExamGradingPage': (context) => const FullExamGradingPage(),
          '/selectFullExamPage': (context) => const SelectFullExamPage(),
          '/selectUnitExamPage': (context) => const SelectUnitExamPage(),
          // '/unitExam': (context) => UnitExamPage(),
          '/unitExamGradingPage': (context) => const UnitExamGradingPage(),
          '/wrongExam': (context) => const WrongExamPage(),
          '/nameMake': (context) => NameMakePage(),

        },
        // ignore: body_might_complete_normally_nullable
        onGenerateRoute: ((settings) {
          if (settings.name == '/unitExam') {
            final args = settings.arguments as UnitExamArguments;
            return MaterialPageRoute(builder: (context) {
              return UnitExamPage(
                arguments: args,
              );
            });
          }
          if (settings.name == '/fullExam') {
            final args = settings.arguments as FullExamArguments;
            return MaterialPageRoute(builder: ((context) {
              return FullExamPage(
                arguments: args,
              );
            }));
          }
        }),
      ),
    );
  }
}
