import 'package:flutter/material.dart';
import 'package:performance_demo/pages/home.dart';
import 'package:show_fps/show_fps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShowFPS(
        alignment: Alignment.bottomCenter,
        visible: true,
        showChart: true,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        child: Home(),
      ),
    );
  }
}
