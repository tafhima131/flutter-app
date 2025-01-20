import 'package:flutter/material.dart';
import 'package:flutter_app/my_project.dart';
import 'package:flutter_app/item_details.dart';
import 'package:flutter_app/all_project.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch:Colors.teal),
      //home: MyProject(),
      home: AllProjects(),
      //home: ItemDetails(),
    );
  }
}

