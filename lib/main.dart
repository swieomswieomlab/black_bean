import 'package:black_bean/test_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'home_page.dart';
import 'firebase_options.dart';

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
      home: TestPage(),
    );
  }
}
