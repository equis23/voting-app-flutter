import 'package:flutter/material.dart';
import 'package:voting_app/screens/screens.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'voting app',
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
      },
    );
  }
}
