import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/login_screen.dart';
import 'package:hinosaapp/screens/started_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HinosaApp',
      home: Scaffold(body: StartedScreen()),
    );
  }
}
