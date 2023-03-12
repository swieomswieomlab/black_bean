import 'package:black_bean/pages/problem_make.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'firebase_options.dart';
import 'pages/test_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  build(BuildContext context) {
    return MaterialApp(
      title: 'Black Bean Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/problemMake',
      routes: {
        '/': (context) => MyHomePage(),
        '/problemMake': (context) => ProblemMake(),
        '/testPage': (context) => TestPage()
      },
    );
  }
}
