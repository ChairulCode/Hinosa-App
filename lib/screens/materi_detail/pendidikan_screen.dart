import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hinosaapp/screens/materi_screen.dart';

class PendidikanScreenDetail extends BaseMateriDetail {
  const PendidikanScreenDetail({super.key});

  @override
  State<PendidikanScreenDetail> createState() => _PendidikanScreenDetailState();
}

class _PendidikanScreenDetailState
    extends BaseMateriDetailState<PendidikanScreenDetail> {
  String materiTitle = "";
  Color materiColor = Colors.blue;
  List<Map<String, dynamic>> materiSections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMateriFromJson();
  }

  Future<void> loadMateriFromJson() async {
    final String response = await rootBundle.loadString(
      "assets/data/data_pendidikan.json",
    );
    final data = json.decode(response);

    setState(() {
      materiTitle = data["title"];
      materiColor = _parseColor(data["color"]);
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

  Color _parseColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case "red":
        return Colors.red;
      case "green":
        return Colors.green;
      case "blue":
        return Colors.blue;
      case "yellow":
        return Colors.yellow;
      default:
        return Colors.blueGrey;
    }
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
