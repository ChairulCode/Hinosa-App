import 'package:flutter/material.dart';

class GlosariumScreen extends StatefulWidget {
  const GlosariumScreen({super.key});

  @override
  State<GlosariumScreen> createState() => _GlosariumScreenState();
}

class _GlosariumScreenState extends State<GlosariumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('glosarium')));
  }
}
