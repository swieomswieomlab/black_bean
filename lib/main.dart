import 'package:black_bean/pages/login_page.dart';
import 'package:black_bean/pages/problem_make.dart';
import 'package:black_bean/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'firebase_options.dart';
// import 'pages/image_picker_test.dart';
import 'pages/test_page.dart';
import 'package:flutter/foundation.dart';

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
    return MaterialApp(
      title: 'Black Bean Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/problemMake',
      routes: {
        '/': (context) => MyHomePage(),
        '/problemMake': (context) => ProblemMake(),
        '/testPage': (context) => TestPage(),
        // '/imageTestPage': (context) => HomePage(),
        '/loginPage': (context) => LoginPage(),
        '/signinPage': (context) => SignUpPage(),
      },
    );
  }
}
