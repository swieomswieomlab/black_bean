import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var firebase = FirebaseFirestore.instance;

  Future<void> addUser(String email, String userId, String userName) async {
    firebase.collection("users").doc(userId).set({
      "email": email,
      "userName": userName,
      "userId": userId,
    });
  }

  TextEditingController idController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
              Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("name")))),
          GestureDetector(
              onTap: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: idController.text,
                          password: pwdController.text)
                      .then((value) {
                    if (value.user!.email == null) {
                    } else {
                      addUser(idController.text, value.user!.uid, nameController.text);
                      Navigator.pop(context);
                    }
                    return value;
                  });
                  FirebaseAuth.instance.currentUser?.sendEmailVerification();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('the password provided is too weak');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  } else {
                    print(e);
                  }
                } catch (e) {
                  print('끝');
                }
              },
              child: Container(
                width: 328,
                height: 48,
                color: Colors.amber,
                child: Center(child: Text('회원가입')),
              ))
        ],
      ),
    );
  }
}
