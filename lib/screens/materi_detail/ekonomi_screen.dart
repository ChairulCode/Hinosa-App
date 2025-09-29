import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hinosaapp/screens/materi_screen.dart';

class EkonomiScreenDetail extends BaseMateriDetail {
  const EkonomiScreenDetail({super.key});

  @override
  State<EkonomiScreenDetail> createState() => _EkonomiScreenDetailState();
}

class _EkonomiScreenDetailState
    extends BaseMateriDetailState<EkonomiScreenDetail> {
  String materiTitle = "";
  final Color materiColor = const Color.fromARGB(255, 218, 4, 11);
  List<Map<String, dynamic>> materiSections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMateriFromJson();
  }

  Future<void> loadMateriFromJson() async {
    final String response = await rootBundle.loadString(
      "assets/data/data_ekonomi.json",
    );
    final data = json.decode(response);

    setState(() {
      materiTitle = data["title"];
      materiSections =
          (data["sections"] as List).map((s) {
            return {
              "title": s["title"],
              "content": List<String>.from(s["content"]),
            };
          }).toList();
      isLoading = false;
    });
  }

  @override
  String get title => materiTitle;

  @override
  Color get color => materiColor;

  @override
  List<Map<String, dynamic>> get sections => materiSections;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return super.build(context);
  }
}
