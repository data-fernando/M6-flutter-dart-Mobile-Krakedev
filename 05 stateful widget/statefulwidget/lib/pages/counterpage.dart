import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CounterPageState();
  }
}

class CounterPageState extends State {
  int counter = 0;

  void incrementCounter() {
    counter++;
    print("Pressed $counter");
    setState(() {}); // como el useState de react
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(backgroundColor: Colors.cyanAccent),
      body: Center(
        child: Text(
          "$counter",
          style: TextStyle(fontSize: 20, fontFamily: "Arial"),
        ),
      ),
    );
  }
}
