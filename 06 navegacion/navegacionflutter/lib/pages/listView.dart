import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ListViewPage')),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Persona 1'),
            subtitle: Text('Subtitulo 1'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Persona 2'),
            subtitle: Text('Subtitulo 2'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Persona 3'),
            subtitle: Text('Subtitulo 3'),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      )
    );
  }
}