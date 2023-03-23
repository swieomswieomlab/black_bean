import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("e-mail")))),
          Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                controller: pwdController,
                obscureText: true, //비번 *****<--- 으로 보이도록
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("password")),
              )),
          GestureDetector(
              onTap: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: idController.text,
                          password: pwdController.text) //아이디와 비밀번호로 로그인 시도
                      .then((value) {
                    print(value);
                    value.user!.emailVerified == true //이메일 인증 여부
                        ? Navigator.pushNamed(context, '/')
                        : print('이메일 확인 안댐');
                    return value;
                  });
                } on FirebaseAuthException catch (e) {
                  //로그인 예외처리
                  if (e.code == 'user-not-found') {
                    print('등록되지 않은 이메일입니다');
                  } else if (e.code == 'wrong-password') {
                    print('비밀번호가 틀렸습니다');
                  } else {
                    print(e.code);
                  }
                }
              },
              child: Container(
                child: Center(
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                width: 100,
                height: 50,
                color: Colors.black,
              )),
              //route button to sign in page
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signinPage');
              },
              child: Container(
                child: Center(
                  child: Text(
                    '회원가입',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                width: 100,
                height: 50,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
