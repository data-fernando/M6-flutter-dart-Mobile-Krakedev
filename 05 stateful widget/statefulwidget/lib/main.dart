import 'package:flutter/material.dart';
import 'package:statefulwidget/pages/calculadora.dart';
import 'package:statefulwidget/pages/counterpage.dart';
import 'package:statefulwidget/pages/welcomepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: CounterPage(),
      // home: WelcomePage(),
      home: CalculatorPage(),
    );
  }
}
