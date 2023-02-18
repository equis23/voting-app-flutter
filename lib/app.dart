import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'voting app',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('voting app'),
        ),
        body: const Center(
          child: Text('here goes the data'),
        ),
      ),
    );
  }
}
