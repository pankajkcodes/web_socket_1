import 'package:flutter/material.dart';
import 'package:web_socket_1/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Socket Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const HomeScreen(),
    );
  }
}
