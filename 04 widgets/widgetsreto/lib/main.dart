import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

const double spaced=50;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "APP TEST",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
          shadowColor: Colors.black,
          elevation: 30,
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  SizedBox(width: spaced),
                  Icon(Icons.home, color: Colors.blue),
                  SizedBox(width: spaced),
                  Text("Home", style: TextStyle(color: Colors.blue)),
                ],
              ),
              Row(
                children: const [
                  SizedBox(width: spaced),
                  Icon(Icons.settings, color: Colors.green),
                  SizedBox(width: spaced),
                  Text("Settings", style: TextStyle(color: Colors.green)),
                ],
              ),
              Row(
                children: const [
                  SizedBox(width: spaced),
                  Icon(Icons.info, color: Colors.orange),
                  SizedBox(width: spaced),
                  Text("Info", style: TextStyle(color: Colors.orange)),
                ],
              ),
              Row(
                children: const [
                  SizedBox(width: spaced),
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Logout", style: TextStyle(color: Colors.red)),
                ],
              ),
            ],
          ),
        ),

        body: const Center(child: Text("Hello World!")),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[300],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
