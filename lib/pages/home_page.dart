import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Text(
              'Hello World!',
            ),
            //button that navigates to the image picker page
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/imageTestPage');
              }
              ,
              child: const Text('image picker test'),
            ),
          ],
        ),
      ),
    );
  }
}
