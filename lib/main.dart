import 'package:flutter/material.dart';
import 'package:ch7_animation_controller/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Animation Controller',
      home: Home(),
    );
  }
}