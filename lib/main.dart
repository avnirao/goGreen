import 'package:flutter/material.dart';
import 'package:go_green/views/home_page.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Green App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), // Set HomePage as the home screen
    );
  }
}
