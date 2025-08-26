import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('flashcard screen')));
  }
}
