import 'package:flutter/material.dart';

class SoalScreen extends StatefulWidget {
  const SoalScreen({super.key});

  @override
  State<SoalScreen> createState() => _SoalScreenState();
}

class _SoalScreenState extends State<SoalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('soal screen')));
  }
}
