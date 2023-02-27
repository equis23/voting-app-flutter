import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/screens/screens.dart';
import 'package:voting_app/services/socket_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => SocketService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'voting app',
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomePage(),
          'status': (context) => const StatusPage(),
        },
      ),
    );
  }
}
